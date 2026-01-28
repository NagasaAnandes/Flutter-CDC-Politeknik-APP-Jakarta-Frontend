class BookmarkItem {
  final String id;
  final String type; // 'job' | 'event'
  final String title;
  final String subtitle;

  const BookmarkItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'title': title,
    'subtitle': subtitle,
  };

  factory BookmarkItem.fromJson(Map<String, dynamic> json) {
    return BookmarkItem(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }
}
