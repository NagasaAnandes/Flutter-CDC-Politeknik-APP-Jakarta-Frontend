abstract class JobDetailEvent {
  const JobDetailEvent();
}

/// Event to load job detail by ID
class LoadJobDetail extends JobDetailEvent {
  final String jobId;

  const LoadJobDetail(this.jobId);
}
