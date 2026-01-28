import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';
import '../../auth/widgets/login_bottom_sheet.dart';

import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../models/notification_item.dart';
import '../widgets/notification_empty_view.dart';
import '../widgets/notification_list_item.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(const LoadNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.go('/app');
          },
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          // ===== GUEST =====
          if (authState is AuthGuest) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_outline, size: 72),
                    const SizedBox(height: 16),
                    const Text(
                      'Login diperlukan untuk melihat notifikasi',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => LoginBottomSheet(
                            onSuccess: () {
                              Navigator.of(context).pop();
                              context.read<NotificationBloc>().add(
                                const LoadNotifications(),
                              );
                            },
                          ),
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            );
          }

          // ===== AUTHENTICATED =====
          if (authState is AuthAuthenticated) {
            return BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is NotificationError) {
                  return Center(child: Text(state.message));
                }

                if (state is NotificationLoaded) {
                  if (state.items.isEmpty) {
                    return const NotificationEmptyView();
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.items.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = state.items[index];

                      return NotificationListItem(
                        icon: _iconForType(item.type),
                        title: item.title,
                        body: item.body,
                        isRead: item.isRead,
                        onTap: () {
                          context.read<NotificationBloc>().add(
                            MarkNotificationRead(item.id),
                          );

                          // navigation ke job/event nanti (Step D)
                        },
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  IconData _iconForType(NotificationType type) {
    switch (type) {
      case NotificationType.job:
        return Icons.work_outline;
      case NotificationType.event:
        return Icons.event_outlined;
      case NotificationType.system:
        return Icons.notifications_outlined;
    }
  }
}
