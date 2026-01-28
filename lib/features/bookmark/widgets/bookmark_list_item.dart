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

    return ListTile(
      leading: Icon(
        leadingIcon ?? Icons.bookmark,
        color: theme.colorScheme.primary,
      ),
      title: Text(title, style: theme.textTheme.bodyLarge),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
        onPressed: onRemove,
      ),
      onTap: onTap,
    );
  }
}
