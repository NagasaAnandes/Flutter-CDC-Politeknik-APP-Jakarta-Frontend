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
        title: 'SPV QC Produksi',
        company: 'MOZAK Furnitures',
        location: 'Jakarta Timur',
        postedAt: now,
        isPartner: true,
        experience: "1 thn",
        education: "D3",
        companyLogoUrl: "assets/images/Logo_Politeknik_APP.png",
        posterUrl: "assets/images/poster_1.jpg",
        applyUrl:
            "mailto:nagasa.anandes@gmail.com?subject=Lamaran%20IT%20Support",
      ),
      JobModel(
        id: '2',
        title: 'Admin Office',
        company: 'CV Maju Jaya',
        location: 'Depok',
        postedAt: now.subtract(const Duration(days: 1)),
        experience: "<1 thn",
        education: "S2",
        isPartner: false,
        posterUrl: "assets/images/poster_2.jpg",
        applyUrl: "https://stockbit.com/watchlist",
      ),
      JobModel(
        id: '3',
        title: 'IT Support',
        company: 'PT Solusi Teknologi',
        location: 'Tangerang',
        postedAt: now.subtract(const Duration(days: 2)),
        isPartner: false,
        experience: "2 thn",
        education: "S1",
        applyUrl:
            "mailto:nagasa.anandes@gmail.com?subject=Lamaran%20IT%20Support",
      ),
      JobModel(
        id: '4',
        title: 'Customer Service',
        company: 'PT Sinar Abadi',
        location: 'Depok',
        postedAt: now.subtract(const Duration(days: 3)),
        isPartner: true,
        experience: "10 thn",
        education: "S1",
        applyUrl:
            "mailto:nagasa.anandes@gmail.com?subject=Lamaran%20IT%20Support",
      ),
    ];
  }

  void _onRefreshJobs(RefreshJobs event, Emitter<JobState> emit) {}
}
