class AnnouncementModel {
  final String id;
  final String title;
  final String summary;
  final DateTime publishedAt;
  final bool isPinned;
  final String? posterUrl;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.publishedAt,
    this.isPinned = false,
    this.posterUrl,
  });
}
