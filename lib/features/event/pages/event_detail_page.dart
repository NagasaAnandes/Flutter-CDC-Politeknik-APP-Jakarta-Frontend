import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/core/widgets/detail_bottom_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/bookmark_service.dart';
import '../../../core/utils/app_tracker.dart';

import '../../bookmark/models/bookmark_item.dart';
import '../../notification/models/notification_item.dart';
import '../../notification/services/notification_service.dart';

import '../bloc/event_detail_bloc.dart';
import '../bloc/event_detail_event.dart';
import '../bloc/event_detail_state.dart';
import '../models/event_model.dart';
import '../widgets/event_detail_content.dart';

class EventDetailPage extends StatefulWidget {
  final String eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();

    context.read<EventDetailBloc>().add(LoadEventDetail(widget.eventId));

    _loadBookmark();
  }

  Future<void> _loadBookmark() async {
    final value = await BookmarkService.isBookmarked(widget.eventId);
    if (!mounted) return;
    setState(() => _isBookmarked = value);
  }

  Future<void> _toggleBookmark(EventModel event) async {
    final bookmarked = await BookmarkService.toggleBookmark(
      BookmarkItem(
        id: event.id,
        type: 'event',
        title: event.title,
        subtitle: event.organizer,
      ),
    );

    if (!mounted) return;
    setState(() => _isBookmarked = bookmarked);

    if (bookmarked) {
      await NotificationService.add(
        NotificationItem(
          id: DateTime.now().toIso8601String(),
          type: NotificationType.event,
          title: 'Event disimpan',
          body: '${event.title} ditambahkan ke bookmark',
          createdAt: DateTime.now(),
          isRead: false,
          referenceId: event.id,
        ),
      );
    }
  }

  Future<void> _registerEvent(EventModel event) async {
    AppTracker.trackEventRegister(
      eventId: event.id,
      organizer: event.organizer,
      registrationUrl: event.registrationUrl,
    );

    final uri = Uri.parse(event.registrationUrl);
    final success = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka tautan pendaftaran')),
      );
      return;
    }

    await NotificationService.add(
      NotificationItem(
        id: DateTime.now().toIso8601String(),
        type: NotificationType.event,
        title: 'Pendaftaran event',
        body: 'Kamu mengunjungi halaman pendaftaran ${event.title}',
        createdAt: DateTime.now(),
        isRead: false,
        referenceId: event.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        title: const Text('Detail Event'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),

      // ===== BODY (SCROLL DI SINI) =====
      body: BlocBuilder<EventDetailBloc, EventDetailState>(
        builder: (context, state) {
          if (state is EventDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EventDetailError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(state.message),
                ],
              ),
            );
          }

          if (state is EventDetailLoaded) {
            final event = state.event;

            return Column(
              children: [
                // 🔥 SCROLLABLE CONTENT
                Expanded(child: EventDetailContent(event: event)),

                // 🔥 FIXED CTA
                DetailBottomBar(
                  isSecondaryActive: _isBookmarked,
                  onSecondaryAction: () => _toggleBookmark(event),
                  onPrimaryAction: () => _registerEvent(event),
                  primaryLabel: 'Kunjungi Informasi Pendaftaran',
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
