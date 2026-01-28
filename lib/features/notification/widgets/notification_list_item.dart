import 'package:flutter/material.dart';

class NotificationListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isRead
            ? theme.colorScheme.onSurfaceVariant
            : theme.colorScheme.primary,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
        ),
      ),
      subtitle: Text(
        body,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      onTap: onTap,
    );
  }
}
