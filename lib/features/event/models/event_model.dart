class EventModel {
  final String id;
  final String title;
  final String organizer;
  final String location;
  final DateTime eventDate;
  final String registrationUrl;
  final bool isFeatured;
  final String? organizerLogoUrl;
  final String? posterUrl;

  const EventModel({
    required this.id,
    required this.title,
    required this.organizer,
    required this.location,
    required this.eventDate,
    required this.registrationUrl,
    this.isFeatured = false,
    this.organizerLogoUrl,
    this.posterUrl,
  });
}
