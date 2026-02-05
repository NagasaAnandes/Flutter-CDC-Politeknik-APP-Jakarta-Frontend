import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/core/widgets/search_empty_view.dart';

import '../../../core/widgets/search_bar.dart';
import '../../../core/layout/app_content_layout.dart';
import '../../../core/layout/app_layout_config.dart';

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
            final filteredEvents = state.events.where((event) {
              final keyword = _query.toLowerCase();
              return event.title.toLowerCase().contains(keyword) ||
                  event.organizer.toLowerCase().contains(keyword) ||
                  event.location.toLowerCase().contains(keyword);
            }).toList();

            return Column(
              children: [
                // ================= SEARCH SECTION =================
                Container(
                  width: double.infinity,
                  color: colorScheme.surfaceContainerHighest,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: AppContentLayout(
                    type: LayoutType.home,
                    child: AppSearchBar(
                      hintText: 'Cari event',
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() => _query = value);
                      },
                    ),
                  ),
                ),

                // ================= CONTENT =================
                Expanded(
                  child: AppContentLayout(
                    type: LayoutType.home,
                    child: filteredEvents.isEmpty
                        ? _query.isEmpty
                              ? const EventEmptyView()
                              : const SearchEmptyView(
                                  message: 'Event tidak ditemukan',
                                )
                        : EventList(events: filteredEvents),
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
