import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/bookmark/models/bookmark_item.dart';

class BookmarkService {
  static const String _storageKey = 'bookmarks_v2';

  /// Ambil semua bookmark
  static Future<List<BookmarkItem>> getAllBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_storageKey) ?? [];

    return raw.map((e) => BookmarkItem.fromJson(jsonDecode(e))).toList();
  }

  /// Cek apakah ID sudah dibookmark
  static Future<bool> isBookmarked(String id) async {
    final items = await getAllBookmarks();
    return items.any((e) => e.id == id);
  }

  /// Toggle bookmark (add / remove)
  static Future<bool> toggleBookmark(BookmarkItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getAllBookmarks();

    final exists = items.indexWhere((e) => e.id == item.id);

    if (exists >= 0) {
      items.removeAt(exists);
    } else {
      items.add(item);
    }

    final encoded = items.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(_storageKey, encoded);
    return exists < 0;
  }

  /// Remove specific bookmark
  static Future<void> remove(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getAllBookmarks()
      ..removeWhere((e) => e.id == id);

    final encoded = items.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(_storageKey, encoded);
  }
}
