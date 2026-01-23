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

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline),
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
                    // Event title
                    Text(
                      event.title,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Organizer + featured + location
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            event.organizer,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),

                        if (event.isFeatured) ...[
                          const SizedBox(width: 4),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: colorScheme.primary,
                          ),
                        ],

                        const SizedBox(width: 6),

                        Text(
                          '• ${event.location}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // ===== EVENT DATE =====
                    MetaItem(
                      icon: Icons.event_outlined,
                      label: _formatDate(event.eventDate),
                    ),
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
