import 'package:flutter_bloc/flutter_bloc.dart';
import 'job_event.dart';
import '../models/job_model.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobBloc() : super(JobInitial()) {
    on<LoadJobs>(_onLoadJobs);
    on<RefreshJobs>(_onRefreshJobs);
  }

  void _onLoadJobs(LoadJobs event, Emitter<JobState> emit) {
    emit(JobLoading());

    final jobs = _mockJobs();

    // SORT: terbaru di atas
    jobs.sort((a, b) => b.postedAt.compareTo(a.postedAt));

    emit(JobLoaded(jobs));
  }

  List<JobModel> _mockJobs() {
    final now = DateTime.now();

    return [
      JobModel(
        id: '1',
        title: 'Staff Administrasi',
        company: 'PT Logistik Nusantara',
        location: 'Jakarta',
        postedAt: now.subtract(const Duration(hours: 2)),
      ),
      JobModel(
        id: '2',
        title: 'Marketing Officer',
        company: 'CV Kreatif Digital',
        location: 'Bekasi',
        postedAt: now.subtract(const Duration(days: 1)),
      ),
      JobModel(
        id: '3',
        title: 'IT Support',
        company: 'PT Solusi Teknologi',
        location: 'Tangerang',
        postedAt: now.subtract(const Duration(days: 2)),
      ),
      JobModel(
        id: '4',
        title: 'Customer Service',
        company: 'PT Sinar Abadi',
        location: 'Depok',
        postedAt: now.subtract(const Duration(days: 3)),
      ),
    ];
  }

  void _onRefreshJobs(RefreshJobs event, Emitter<JobState> emit) {}
}
