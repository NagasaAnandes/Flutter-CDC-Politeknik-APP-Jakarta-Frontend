import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/search_bar.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_state.dart';
import '../widgets/event_empty.dart';
import '../widgets/event_list.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  double _horizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 32; // tablet landscape
    if (width >= 600) return 24; // tablet portrait
    return 16; // mobile
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        surfaceTintColor: Colors.transparent,
      ),

      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EventLoaded) {
            final events = state.events;

            // ===== LOCAL SEARCH FILTER =====
            final filteredEvents = events.where((event) {
              final keyword = _query.toLowerCase();
              return event.title.toLowerCase().contains(keyword) ||
                  event.organizer.toLowerCase().contains(keyword) ||
                  event.location.toLowerCase().contains(keyword);
            }).toList();

            return Column(
              children: [
                // ================= SEARCH SECTION =================
                Container(
                  padding: EdgeInsets.fromLTRB(
                    _horizontalPadding(context),
                    16,
                    _horizontalPadding(context),
                    16,
                  ),
                  color: colorScheme.surfaceContainerHighest,
                  child: AppSearchBar(
                    hintText: 'Cari event',
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() => _query = value);
                    },
                  ),
                ),

                // ================= CONTENT =================
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: _horizontalPadding(context),
                        ),
                        child: filteredEvents.isEmpty
                            ? _query.isEmpty
                                  ? const EventEmptyView()
                                  : const _SearchEmptyView(
                                      message: 'Event tidak ditemukan',
                                    )
                            : EventList(events: filteredEvents),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is EventError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _SearchEmptyView extends StatelessWidget {
  final String message;

  const _SearchEmptyView({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
