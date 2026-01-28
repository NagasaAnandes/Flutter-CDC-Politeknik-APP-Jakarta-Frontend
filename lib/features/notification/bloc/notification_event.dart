import '../models/notification_item.dart';

abstract class NotificationEvent {
  const NotificationEvent();
}

class LoadNotifications extends NotificationEvent {
  const LoadNotifications();
}

class AddNotification extends NotificationEvent {
  final NotificationItem item;
  const AddNotification(this.item);
}

class MarkNotificationRead extends NotificationEvent {
  final String id;
  const MarkNotificationRead(this.id);
}
