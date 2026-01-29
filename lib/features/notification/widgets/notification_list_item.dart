import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;
  final VoidCallback onTap;

  const NotificationListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor = isRead
        ? colorScheme.surfaceContainerHighest
        : colorScheme.primaryContainer.withValues(alpha: 0.6);

    return ListTile(
      onTap: onTap,
      tileColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: CircleAvatar(
        backgroundColor: isRead
            ? colorScheme.surfaceContainerHighest
            : colorScheme.primaryContainer,
        child: Icon(
          icon,
          color: isRead
              ? colorScheme.onSurfaceVariant
              : colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(body),
          const SizedBox(height: 4),
          Text(
            _formatTime(createdAt),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays == 1) return 'Kemarin';

    return DateFormat('dd MMM yyyy').format(time);
  }
}
