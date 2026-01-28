import '../models/notification_item.dart';

abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationLoaded extends NotificationState {
  final List<NotificationItem> items;

  const NotificationLoaded(this.items);

  int get unreadCount => items.where((e) => !e.isRead).length;
}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);
}
