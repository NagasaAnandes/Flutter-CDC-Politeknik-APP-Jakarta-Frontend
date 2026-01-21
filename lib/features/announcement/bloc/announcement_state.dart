import '../models/announcement_model.dart';

class AnnouncementState {
  final List<AnnouncementModel> items;
  final bool isLoading;
  final String? error;

  const AnnouncementState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  AnnouncementState copyWith({
    List<AnnouncementModel>? items,
    bool? isLoading,
    String? error,
  }) {
    return AnnouncementState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
