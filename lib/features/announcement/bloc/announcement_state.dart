import '../models/announcement_model.dart';

abstract class AnnouncementState {}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementLoaded extends AnnouncementState {
  final List<AnnouncementModel> items;

  AnnouncementLoaded(this.items);
}

class AnnouncementError extends AnnouncementState {
  final String message;

  AnnouncementError(this.message);
}
