import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/bookmark_service.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';
import '../../auth/widgets/login_bottom_sheet.dart';

import '../models/bookmark_item.dart';
import '../widgets/bookmark_empty_view.dart';
import '../widgets/bookmark_list_item.dart';

import '../../job/bloc/job_bloc.dart';
import '../../job/bloc/job_state.dart';
import '../../event/bloc/event_bloc.dart';
import '../../event/bloc/event_state.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<BookmarkItem> _items = [];
  BookmarkItem? _lastRemoved;
  int? _lastRemovedIndex;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _openBookmark(BuildContext context, BookmarkItem item) {
    if (item.type == 'job') {
      final jobState = context.read<JobBloc>().state;

      if (jobState is JobLoaded) {
        final jobs = jobState.jobs.where((e) => e.id == item.id).toList();

        if (jobs.isNotEmpty) {
          final job = jobs.first;

          context.goNamed(
            'jobDetail',
            pathParameters: {'id': job.id},
            extra: job,
          );
          return;
        }
      }
    }

    if (item.type == 'event') {
      final eventState = context.read<EventBloc>().state;

      if (eventState is EventLoaded) {
        final events = eventState.events.where((e) => e.id == item.id).toList();

        if (events.isNotEmpty) {
          final event = events.first;

          context.goNamed(
            'eventDetail',
            pathParameters: {'id': event.id},
            extra: event,
          );
          return;
        }
      }
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data detail belum tersedia')));
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);

    final data = await BookmarkService.getAllBookmarks();
    if (!mounted) return;

    setState(() {
      _items = data.reversed.toList();
      _isLoading = false;
    });
  }

  Future<void> _removeWithUndo(BookmarkItem item, int index) async {
    setState(() {
      _lastRemoved = item;
      _lastRemovedIndex = index;
      _items.removeAt(index);
    });

    await BookmarkService.remove(item.id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} dihapus'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () async {
            if (_lastRemoved != null && _lastRemovedIndex != null) {
              await BookmarkService.toggleBookmark(_lastRemoved!);
              await _load();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark Saya'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.go('/app/profile');
          },
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthGuest) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => LoginBottomSheet(
                      onSuccess: () {
                        Navigator.of(context).pop();
                        _load();
                      },
                    ),
                  );
                },
                child: const Text('Login untuk melihat bookmark'),
              ),
            );
          }

          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_items.isEmpty) {
            return const BookmarkEmptyView();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _items.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, index) {
              final item = _items[index];

              return BookmarkListItem(
                leadingIcon: item.type == 'job' ? Icons.work : Icons.event,
                title: item.title,
                subtitle: item.subtitle,
                onTap: () => _openBookmark(context, item),
                onRemove: () => _removeWithUndo(item, index),
              );
            },
          );
        },
      ),
    );
  }
}
