import '../models/event_model.dart';

/// Repository layer for Event data
/// Currently uses mock data, but API-ready for future integration
class EventRepository {
  // Cache to avoid recreating mock data on every call
  List<EventModel>? _cachedEvents;

  /// Fetch all events
  /// Returns a sorted list of events by event date (nearest first)
  Future<List<EventModel>> getEvents() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (_cachedEvents != null) {
      return List.from(_cachedEvents!);
    }

    final events = _mockEvents();
    events.sort((a, b) => b.eventDate.compareTo(a.eventDate));

    _cachedEvents = events;
    return List.from(events);
  }

  /// Fetch a single event by ID
  /// Throws [EventNotFoundException] if event is not found
  Future<EventModel> getEventById(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Ensure data is loaded
    final events = await getEvents();

    try {
      return events.firstWhere((event) => event.id == id);
    } catch (_) {
      throw EventNotFoundException('Event dengan ID $id tidak ditemukan');
    }
  }

  /// Clear cache (useful for refresh)
  void clearCache() {
    _cachedEvents = null;
  }

  // ===== MOCK DATA =====
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
      EventModel(
        id: '4',
        title: 'Workshop Persiapan Karier',
        organizer: 'CDC Politeknik APP Jakarta',
        location: 'Online (Zoom)',
        eventDate: now.add(const Duration(days: 21)),
        registrationUrl: 'https://forms.gle/workshop-karier',
      ),
    ];
  }
}

/// Custom exception for when an event is not found
class EventNotFoundException implements Exception {
  final String message;
  EventNotFoundException(this.message);

  @override
  String toString() => message;
}
