import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/event_model.dart';
import 'event_card.dart';

class EventList extends StatelessWidget {
  final List<EventModel> events;

  const EventList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];

        return EventCard(
          event: event,
          onTap: () {
            context.push('/app/event/${event.id}');
          },
        );
      },
    );
  }
}
