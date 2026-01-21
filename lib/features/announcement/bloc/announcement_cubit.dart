import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/announcement_model.dart';
import 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit() : super(const AnnouncementState());

  void loadAnnouncements() {
    emit(state.copyWith(isLoading: true));

    final items = _mockAnnouncements();

    // Sort: pinned first, newest first
    items.sort((a, b) {
      if (a.isPinned != b.isPinned) {
        return a.isPinned ? -1 : 1;
      }
      return b.publishedAt.compareTo(a.publishedAt);
    });

    if (kDebugMode) {
      debugPrint('=== ANNOUNCEMENT LOADED ===');
      for (final e in items) {
        debugPrint('id=${e.id}, pinned=${e.isPinned}, poster=${e.posterUrl}');
      }
    }

    emit(state.copyWith(items: items, isLoading: false));
  }

  /// Mock sementara (API nanti)
  List<AnnouncementModel> _mockAnnouncements() {
    final now = DateTime.now();

    return [
      AnnouncementModel(
        id: '1',
        title: 'Pendaftaran Tracer Study Dibuka',
        summary: 'Wajib diisi oleh alumni lulusan 2023–2024.',
        publishedAt: now,
        isPinned: true,
        posterUrl: 'assets/images/poster_1.jpg',
      ),
      AnnouncementModel(
        id: '2',
        title: 'Seminar Karier Februari',
        summary: 'Persiapan karier bersama praktisi industri.',
        publishedAt: now.subtract(const Duration(days: 1)),
      ),
      AnnouncementModel(
        id: '3',
        title: 'Seminar Magang Internasional',
        summary: 'Peluang magang di perusahaan global.',
        publishedAt: now.subtract(const Duration(days: 2)),
      ),
    ];
  }
}
