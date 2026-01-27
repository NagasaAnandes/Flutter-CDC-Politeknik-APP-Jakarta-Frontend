import 'package:flutter/material.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/auth_guard.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/widgets/login_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/app_tracker.dart';
import '../../../core/services/bookmark_service.dart';

import '../models/event_model.dart';
import '../../job/widgets/company_avatar.dart';
import '../../job/widgets/meta_item.dart';
import '../../job/widgets/job_poster.dart';

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
    final value = await BookmarkService.toggleBookmark(widget.event.id);
    if (!mounted) return;
    setState(() => _isBookmarked = value);
  }

  Future<void> _registerEvent() async {
    AppTracker.trackEventRegister(
      eventId: widget.event.id,
      organizer: widget.event.organizer,
      registrationUrl: widget.event.registrationUrl,
    );

    final uri = Uri.parse(widget.event.registrationUrl);

    final success = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka tautan pendaftaran')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Event')),

      // ===== BODY =====
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
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
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.event.organizer,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          if (widget.event.isFeatured) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.star,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                          ],
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

            // ===== META (EVENT DATE) =====
            MetaItem(
              icon: Icons.event_outlined,
              label: _formatDate(widget.event.eventDate),
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // ===== EVENT POSTER (OPTIONAL) =====
            if (widget.event.posterUrl != null) ...[
              OutlinedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) {
                      return SafeArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: JobPoster(posterUrl: widget.event.posterUrl!),
                        ),
                      );
                    },
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
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),

      // ===== BOTTOM ACTION BAR =====
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // ===== BOOKMARK =====
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

              // ===== REGISTER BUTTON =====
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
