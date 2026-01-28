import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/notification/services/notification_service.dart';

import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationInitial()) {
    on<LoadNotifications>(_onLoad);
    on<AddNotification>(_onAdd);
    on<MarkNotificationRead>(_onMarkRead);
  }

  Future<void> _onLoad(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());
    try {
      final items = await NotificationService.getAll();
      emit(
        NotificationLoaded(
          items..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
        ),
      );
    } catch (e) {
      emit(const NotificationError('Gagal memuat notifikasi'));
    }
  }

  Future<void> _onAdd(
    AddNotification event,
    Emitter<NotificationState> emit,
  ) async {
    await NotificationService.add(event.item);
    add(const LoadNotifications());
  }

  Future<void> _onMarkRead(
    MarkNotificationRead event,
    Emitter<NotificationState> emit,
  ) async {
    await NotificationService.markAsRead(event.id);
    add(const LoadNotifications());
  }
}
