abstract class EventDetailEvent {
  const EventDetailEvent();
}

/// Event to load event detail by ID
class LoadEventDetail extends EventDetailEvent {
  final String eventId;

  const LoadEventDetail(this.eventId);
}
