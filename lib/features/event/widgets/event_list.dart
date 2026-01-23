import 'package:flutter/material.dart';
import 'event_card.dart';
import '../models/event_model.dart';
import 'package:go_router/go_router.dart';

class EventList extends StatelessWidget {
  final List<EventModel> events;

  const EventList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];

        return EventCard(
          event: event,
          onTap: () {
            context.push('/app/event/${event.id}', extra: event);
          },
        );
      },
    );
  }
}
