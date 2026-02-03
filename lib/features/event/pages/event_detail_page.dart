import 'package:flutter/material.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/auth_guard.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/widgets/login_bottom_sheet.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/bookmark/models/bookmark_item.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/notification/models/notification_item.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/notification/services/notification_service.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/app_tracker.dart';
import '../../../core/services/bookmark_service.dart';

import '../models/event_model.dart';
import '../../../core/widgets/company_avatar.dart';
import '../../../core/widgets/meta_item.dart';
import '../../../core/widgets/poster_viewer.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _loadBookmark();
  }

  Future<void> _loadBookmark() async {
    final value = await BookmarkService.isBookmarked(widget.event.id);
    if (!mounted) return;
    setState(() => _isBookmarked = value);
  }

  Future<void> _toggleBookmark() async {
    final bookmarked = await BookmarkService.toggleBookmark(
      BookmarkItem(
        id: widget.event.id,
        type: 'event',
        title: widget.event.title,
        subtitle: widget.event.organizer,
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
          body: '${widget.event.title} ditambahkan ke bookmark',
          createdAt: DateTime.now(),
          isRead: false,
          referenceId: widget.event.id,
        ),
      );
    }
  }

  Future<void> _registerEvent() async {
    AppTracker.trackEventRegister(
      eventId: widget.event.id,
      organizer: widget.event.organizer,
      registrationUrl: widget.event.registrationUrl,
    );

    final uri = Uri.parse(widget.event.registrationUrl);
    final success = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!success) {
      if (!mounted) return;
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
        body: 'Kamu mengunjungi halaman pendaftaran ${widget.event.title}',
        createdAt: DateTime.now(),
        isRead: false,
        referenceId: widget.event.id,
      ),
    );
  }

  double _horizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 32;
    if (width >= 600) return 24;
    return 16;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final metas = [
      MetaItem(
        icon: Icons.event_outlined,
        label: _formatDate(widget.event.eventDate),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Detail Event',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(context),
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== HEADER =====
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CompanyAvatar(
                        company: widget.event.organizer,
                        logoUrl: widget.event.organizerLogoUrl,
                        size: 56,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.title,
                              style: textTheme.titleLarge,
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  widget.event.organizer,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                if (widget.event.isFeatured)
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: colorScheme.primary,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.event.location,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // ===== META =====
                  Wrap(spacing: 24, runSpacing: 12, children: metas),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // ===== POSTER =====
                  if (widget.event.posterUrl != null) ...[
                    OutlinedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => SafeArea(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: PosterViewer(
                                posterUrl: widget.event.posterUrl!,
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Lihat Poster Event'),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // ===== DESCRIPTION =====
                  Text('Deskripsi Event', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    _dummyDescription(widget.event),
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ================= CTA =================
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  requireAuth(
                    context,
                    onAuthenticated: _toggleBookmark,
                    onUnauthenticated: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) =>
                            LoginBottomSheet(onSuccess: _toggleBookmark),
                      );
                    },
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(48, 48),
                  padding: EdgeInsets.zero,
                ),
                child: Icon(
                  _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    requireAuth(
                      context,
                      onAuthenticated: _registerEvent,
                      onUnauthenticated: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) =>
                              LoginBottomSheet(onSuccess: _registerEvent),
                        );
                      },
                    );
                  },
                  child: const Text('Kunjungi Informasi Pendaftaran'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _dummyDescription(EventModel event) {
    return 'CDC Politeknik APP Jakarta menyelenggarakan '
        '${event.title} yang akan dilaksanakan di ${event.location}. '
        'Event ini terbuka untuk mahasiswa dan alumni.\n\n'
        'Silakan kunjungi tautan pendaftaran untuk informasi lebih lanjut.';
  }
}
