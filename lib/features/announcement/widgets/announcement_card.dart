import 'package:flutter/material.dart';
import '../models/announcement_model.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel item;

  const AnnouncementCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // detail nanti (kalau ada)
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== ICON =====
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.campaign_outlined,
                  size: 22,
                  color: item.isPinned
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(width: 12),

              // ===== CONTENT =====
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      item.title,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // SUMMARY
                    Text(
                      item.summary,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
}
