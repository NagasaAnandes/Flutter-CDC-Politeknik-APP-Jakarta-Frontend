import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/event_repository.dart';
import 'event_detail_event.dart';
import 'event_detail_state.dart';

/// Bloc responsible for managing event detail state
/// This Bloc is independent and fetches its own data via repository
class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final EventRepository _repository;

  EventDetailBloc({EventRepository? repository})
    : _repository = repository ?? EventRepository(),
      super(const EventDetailInitial()) {
    on<LoadEventDetail>(_onLoadEventDetail);
  }

  Future<void> _onLoadEventDetail(
    LoadEventDetail event,
    Emitter<EventDetailState> emit,
  ) async {
    emit(const EventDetailLoading());

    try {
      final eventData = await _repository.getEventById(event.eventId);
      emit(EventDetailLoaded(eventData));
    } catch (e) {
      emit(EventDetailError(e.toString()));
    }
  }
}
