import 'package:flutter/foundation.dart';

class AppTracker {
  // ===== JOB TRACKING =====
  static void trackJobApply({
    required String jobId,
    required String company,
    required String applyUrl,
  }) {
    final timestamp = DateTime.now().toIso8601String();

    if (kDebugMode) {
      debugPrint(
        '[TRACK] job_apply | jobId=$jobId | company=$company | url=$applyUrl | time=$timestamp',
      );
    }
  }

  // ===== EVENT TRACKING =====
  static void trackEventRegister({
    required String eventId,
    required String organizer,
    required String registrationUrl,
  }) {
    final timestamp = DateTime.now().toIso8601String();

    if (kDebugMode) {
      debugPrint(
        '[TRACK] event_register | eventId=$eventId | organizer=$organizer | url=$registrationUrl | time=$timestamp',
      );
    }
  }
}
