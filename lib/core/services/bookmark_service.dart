import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static const _key = 'bookmarked_jobs';

  /// Ambil semua bookmark
  static Future<Set<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.toSet();
  }

  /// Toggle bookmark
  static Future<bool> toggleBookmark(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();

    if (bookmarks.contains(jobId)) {
      bookmarks.remove(jobId);
    } else {
      bookmarks.add(jobId);
    }

    await prefs.setStringList(_key, bookmarks.toList());
    return bookmarks.contains(jobId);
  }

  /// Cek status bookmark
  static Future<bool> isBookmarked(String jobId) async {
    final bookmarks = await getBookmarks();
    return bookmarks.contains(jobId);
  }
}
