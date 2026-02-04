import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/job_repository.dart';
import 'job_detail_event.dart';
import 'job_detail_state.dart';

/// Bloc responsible for managing job detail state
/// This Bloc is independent and fetches its own data via repository
class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
  final JobRepository _repository;

  JobDetailBloc({JobRepository? repository})
    : _repository = repository ?? JobRepository(),
      super(const JobDetailInitial()) {
    on<LoadJobDetail>(_onLoadJobDetail);
  }

  Future<void> _onLoadJobDetail(
    LoadJobDetail event,
    Emitter<JobDetailState> emit,
  ) async {
    emit(const JobDetailLoading());

    try {
      final job = await _repository.getJobById(event.jobId);
      emit(JobDetailLoaded(job));
    } catch (e) {
      emit(JobDetailError(e.toString()));
    }
  }
}
