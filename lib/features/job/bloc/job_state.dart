import '../models/job_model.dart';

abstract class JobState {
  const JobState();
}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<JobModel> jobs;

  const JobLoaded(this.jobs);
}

class JobError extends JobState {
  final String message;

  const JobError(this.message);
}
