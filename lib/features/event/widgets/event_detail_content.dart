import 'package:flutter/material.dart';

import '../../../core/layout/app_content_layout.dart';
import '../../../core/layout/app_layout_config.dart';

import '../../../core/widgets/company_avatar.dart';
import '../../../core/widgets/meta_item.dart';
import '../../../core/widgets/poster_viewer.dart';
import '../models/event_model.dart';

class EventDetailContent extends StatelessWidget {
  final EventModel event;

  const EventDetailContent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final metas = [
      MetaItem(icon: Icons.event_outlined, label: _formatDate(event.eventDate)),
    ];

    return SingleChildScrollView(
      child: AppContentLayout(
        type: LayoutType.detail,
        extraPadding: const EdgeInsets.fromLTRB(
          0,
          24,
          0,
          96,
        ), // ⬅️ aman dari CTA
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== HEADER =====
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CompanyAvatar(
                  company: event.organizer,
                  logoUrl: event.organizerLogoUrl,
                  size: 56,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title, style: textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            event.organizer,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (event.isFeatured)
                            Icon(
                              Icons.star,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        event.location,
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
            if (event.posterUrl != null) ...[
              OutlinedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => SafeArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: PosterViewer(posterUrl: event.posterUrl!),
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
              _dummyDescription(event),
              style: textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ],
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
