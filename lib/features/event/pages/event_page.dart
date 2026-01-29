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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event')),
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
                // ===== SEARCH BAR =====
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppSearchBar(
                    hintText: 'Cari event',
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() => _query = value);
                    },
                  ),
                ),

                // ===== LIST / EMPTY =====
                Expanded(
                  child: filteredEvents.isEmpty
                      ? _query.isEmpty
                            ? const EventEmptyView()
                            : const _SearchEmptyView(
                                message: 'Event tidak ditemukan',
                              )
                      : EventList(events: filteredEvents),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 64),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
