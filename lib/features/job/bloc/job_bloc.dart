import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/job_repository.dart';
import 'job_event.dart';
import 'job_state.dart';

/// Bloc responsible for managing job list state
/// This Bloc only handles the job list, not individual job details
class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository _repository;

  JobBloc({JobRepository? repository})
    : _repository = repository ?? JobRepository(),
      super(JobInitial()) {
    on<LoadJobs>(_onLoadJobs);
    on<RefreshJobs>(_onRefreshJobs);
  }

  Future<void> _onLoadJobs(LoadJobs event, Emitter<JobState> emit) async {
    emit(JobLoading());

    try {
      final jobs = await _repository.getJobs();
      emit(JobLoaded(jobs));
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }

  Future<void> _onRefreshJobs(RefreshJobs event, Emitter<JobState> emit) async {
    // Clear cache before refresh
    _repository.clearCache();

    try {
      final jobs = await _repository.getJobs();
      emit(JobLoaded(jobs));
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }
}
