import 'package:flutter/material.dart';
import '../../job/widgets/company_avatar.dart';
import '../../job/widgets/meta_item.dart';
import '../models/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onTap;

  const EventCard({super.key, required this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final metas = [
      MetaItem(icon: Icons.event_outlined, label: _formatDate(event.eventDate)),
    ];

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.4)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== ORGANIZER AVATAR =====
              CompanyAvatar(
                company: event.organizer,
                logoUrl: event.organizerLogoUrl,
              ),

              const SizedBox(width: 12),

              // ===== CONTENT =====
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== TITLE =====
                    Text(
                      event.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // ===== ORGANIZER + LOCATION =====
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          event.organizer,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),

                        if (event.isFeatured)
                          Icon(
                            Icons.star,
                            size: 14,
                            color: colorScheme.primary,
                          ),

                        Text(
                          '• ${event.location}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ===== META (FUTURE-PROOF) =====
                    Wrap(spacing: 16, runSpacing: 8, children: metas),
                  ],
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
}
