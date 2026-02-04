import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/event_repository.dart';
import 'event_event.dart';
import 'event_state.dart';

/// Bloc responsible for managing event list state
/// This Bloc only handles the event list, not individual event details
class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository _repository;

  EventBloc({EventRepository? repository})
    : _repository = repository ?? EventRepository(),
      super(EventInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<RefreshEvents>(_onRefreshEvents);
  }

  Future<void> _onLoadEvents(LoadEvents event, Emitter<EventState> emit) async {
    emit(EventLoading());

    try {
      final events = await _repository.getEvents();
      emit(EventLoaded(events));
    } catch (e) {
      emit(EventError(e.toString()));
    }
  }

  Future<void> _onRefreshEvents(
    RefreshEvents event,
    Emitter<EventState> emit,
  ) async {
    // Clear cache before refresh
    _repository.clearCache();

    try {
      final events = await _repository.getEvents();
      emit(EventLoaded(events));
    } catch (e) {
      emit(EventError(e.toString()));
    }
  }
}
