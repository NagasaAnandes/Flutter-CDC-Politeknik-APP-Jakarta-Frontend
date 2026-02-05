import 'package:flutter/material.dart';

class BookmarkListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final IconData? leadingIcon;

  const BookmarkListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.onRemove,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                leadingIcon ?? Icons.bookmark_outline,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.delete_outline, color: colorScheme.error),
                onPressed: onRemove,
                tooltip: 'Hapus bookmark',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
