import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_item.dart';

class NotificationService {
  static const String _storageKey = 'notifications';

  /// ================================
  /// Get all notifications
  /// ================================
  static Future<List<NotificationItem>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_storageKey) ?? [];

    return rawList
        .map((e) => NotificationItem.fromJson(jsonDecode(e)))
        .toList();
  }

  /// ================================
  /// Save all notifications (internal)
  /// ================================
  static Future<void> _saveAll(List<NotificationItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = items.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(_storageKey, encoded);
  }

  /// ================================
  /// Add new notification
  /// ================================
  static Future<void> add(NotificationItem item) async {
    final items = await getAll();
    items.add(item);
    await _saveAll(items);
  }

  /// ================================
  /// Mark notification as read
  /// ================================
  static Future<void> markAsRead(String id) async {
    final items = await getAll();

    final updated = items
        .map((e) => e.id == id ? e.copyWith(isRead: true) : e)
        .toList();

    await _saveAll(updated);
  }

  /// ================================
  /// Mark all notifications as read
  /// (future / polish)
  /// ================================
  static Future<void> markAllAsRead() async {
    final items = await getAll();

    final updated = items.map((e) => e.copyWith(isRead: true)).toList();

    await _saveAll(updated);
  }

  /// ================================
  /// Remove one notification
  /// ================================
  static Future<void> remove(String id) async {
    final items = await getAll()
      ..removeWhere((e) => e.id == id);

    await _saveAll(items);
  }

  /// ================================
  /// Clear all notifications
  /// (debug / future)
  /// ================================
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
