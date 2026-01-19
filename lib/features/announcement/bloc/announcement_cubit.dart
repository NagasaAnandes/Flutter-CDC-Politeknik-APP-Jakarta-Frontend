import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/announcement_model.dart';
import 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit() : super(AnnouncementInitial());

  void loadAnnouncements() {
    emit(AnnouncementLoading());

    // Dummy data sementara
    final items = [
      AnnouncementModel(
        id: '1',
        title: 'Pendaftaran Tracer Study Dibuka',
        summary: 'Wajib diisi oleh alumni lulusan 2023–2024.',
        publishedAt: DateTime.now(),
        isPinned: true,
      ),
      AnnouncementModel(
        id: '2',
        title: 'Seminar Karier Februari',
        summary: 'Persiapan karier bersama praktisi industri.',
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      AnnouncementModel(
        id: '3',
        title: 'Seminar Magang Internasional',
        summary: 'Peluang magang di perusahaan global.',
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    emit(AnnouncementLoaded(items));
  }
}
