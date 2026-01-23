import 'package:flutter/foundation.dart';

class AppTracker {
  AppTracker._();

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

    // 🔜 NANTI:
    // - FirebaseAnalytics.logEvent(...)
    // - Kirim ke backend CDC
  }
}
