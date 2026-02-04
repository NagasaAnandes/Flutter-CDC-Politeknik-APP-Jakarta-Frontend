import '../models/job_model.dart';

abstract class JobDetailState {
  const JobDetailState();
}

/// Initial state before any job detail is loaded
class JobDetailInitial extends JobDetailState {
  const JobDetailInitial();
}

/// Loading state while fetching job detail
class JobDetailLoading extends JobDetailState {
  const JobDetailLoading();
}

/// Success state with loaded job detail
class JobDetailLoaded extends JobDetailState {
  final JobModel job;

  const JobDetailLoaded(this.job);
}

/// Error state when job detail fails to load
class JobDetailError extends JobDetailState {
  final String message;

  const JobDetailError(this.message);
}
