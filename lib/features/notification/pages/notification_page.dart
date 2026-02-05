import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';
import '../../auth/widgets/login_bottom_sheet.dart';

import '../../event/bloc/event_bloc.dart';
import '../../event/bloc/event_state.dart';
import '../../job/bloc/job_bloc.dart';
import '../../job/bloc/job_state.dart';

import '../../../core/layout/app_content_layout.dart';
import '../../../core/layout/app_layout_config.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.go('/app'),
        ),
      ),
      body: Container(
        color: theme.colorScheme.surface, // background abu konsisten
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            // ================= GUEST =================
            if (authState is AuthGuest) {
              return AppContentLayout(
                type: LayoutType.home,
                child: Center(
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
                ),
              );
            }

            // ================= AUTHENTICATED =================
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
                      return AppContentLayout(
                        type: LayoutType.home,
                        child: const NotificationEmptyView(),
                      );
                    }

                    return AppContentLayout(
                      type: LayoutType.home,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        itemCount: state.items.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = state.items[index];

                          return NotificationListItem(
                            icon: _iconForType(item.type),
                            title: item.title,
                            body: item.body,
                            isRead: item.isRead,
                            createdAt: item.createdAt,
                            onTap: () {
                              // 1️⃣ tandai sudah dibaca
                              context.read<NotificationBloc>().add(
                                MarkNotificationRead(item.id),
                              );

                              // 2️⃣ navigasi sesuai tipe
                              if (item.type == NotificationType.job) {
                                final jobState = context.read<JobBloc>().state;

                                if (jobState is JobLoaded) {
                                  final jobs = jobState.jobs
                                      .where((j) => j.id == item.referenceId)
                                      .toList();

                                  if (jobs.isNotEmpty) {
                                    final job = jobs.first;
                                    context.go(
                                      '/app/job/${job.id}',
                                      extra: job,
                                    );
                                  } else {
                                    _showNotFoundMessage(
                                      context,
                                      'Lowongan sudah tidak tersedia',
                                    );
                                  }
                                } else {
                                  _showNotFoundMessage(
                                    context,
                                    'Data lowongan belum dimuat',
                                  );
                                }
                              }

                              if (item.type == NotificationType.event) {
                                final eventState = context
                                    .read<EventBloc>()
                                    .state;

                                if (eventState is EventLoaded) {
                                  final events = eventState.events
                                      .where((e) => e.id == item.referenceId)
                                      .toList();

                                  if (events.isNotEmpty) {
                                    final event = events.first;
                                    context.go(
                                      '/app/event/${event.id}',
                                      extra: event,
                                    );
                                  } else {
                                    _showNotFoundMessage(
                                      context,
                                      'Event sudah tidak tersedia',
                                    );
                                  }
                                } else {
                                  _showNotFoundMessage(
                                    context,
                                    'Data event belum dimuat',
                                  );
                                }
                              }
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
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

void _showNotFoundMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
