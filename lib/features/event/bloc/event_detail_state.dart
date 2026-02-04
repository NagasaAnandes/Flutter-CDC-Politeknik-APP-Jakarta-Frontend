import '../models/event_model.dart';

abstract class EventDetailState {
  const EventDetailState();
}

/// Initial state before any event detail is loaded
class EventDetailInitial extends EventDetailState {
  const EventDetailInitial();
}

/// Loading state while fetching event detail
class EventDetailLoading extends EventDetailState {
  const EventDetailLoading();
}

/// Success state with loaded event detail
class EventDetailLoaded extends EventDetailState {
  final EventModel event;

  const EventDetailLoaded(this.event);
}

/// Error state when event detail fails to load
class EventDetailError extends EventDetailState {
  final String message;

  const EventDetailError(this.message);
}
