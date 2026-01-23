import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_event.dart';
import 'event_state.dart';
import '../models/event_model.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<RefreshEvents>(_onRefreshEvents);
  }

  void _onLoadEvents(LoadEvents event, Emitter<EventState> emit) {
    emit(EventLoading());

    final events = _mockEvents();

    // SORT: event terdekat / terbaru di atas
    events.sort((a, b) => b.eventDate.compareTo(a.eventDate));

    emit(EventLoaded(events));
  }

  List<EventModel> _mockEvents() {
    final now = DateTime.now();

    return [
      EventModel(
        id: '1',
        title: 'Seminar Karier Industri Digital',
        organizer: 'CDC Politeknik APP Jakarta',
        location: 'Aula Kampus',
        eventDate: now.add(const Duration(days: 7)),
        isFeatured: true,
        organizerLogoUrl: 'assets/images/Logo_Politeknik_APP.png',
        posterUrl: 'assets/images/poster_1.jpg',
        registrationUrl: 'https://forms.gle/pendaftaran-seminar-karier',
      ),
      EventModel(
        id: '2',
        title: 'Campus Hiring Day',
        organizer: 'PT Solusi Teknologi',
        location: 'Gedung Serbaguna',
        eventDate: now.add(const Duration(days: 14)),
        posterUrl: 'assets/images/poster_2.jpg',
        registrationUrl: 'https://forms.gle/campus-hiring-day',
      ),
      EventModel(
        id: '3',
        title: 'Workshop Persiapan Karier',
        organizer: 'CDC Politeknik APP Jakarta',
        location: 'Online (Zoom)',
        eventDate: now.add(const Duration(days: 21)),
        registrationUrl: 'https://forms.gle/workshop-karier',
      ),
    ];
  }

  void _onRefreshEvents(RefreshEvents event, Emitter<EventState> emit) {
    // placeholder (future API refresh)
  }
}
