import '../models/event_model.dart';

abstract class EventState {
  const EventState();
}

class EventInitial extends EventState {
  const EventInitial();
}

class EventLoading extends EventState {
  const EventLoading();
}

class EventLoaded extends EventState {
  final List<EventModel> events;

  const EventLoaded(this.events);
}

class EventError extends EventState {
  final String message;

  const EventError(this.message);
}
