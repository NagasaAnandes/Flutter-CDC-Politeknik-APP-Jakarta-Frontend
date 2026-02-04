import '../models/job_model.dart';

/// Repository layer for Job data
/// Currently uses mock data, but API-ready for future integration
class JobRepository {
  // Cache to avoid recreating mock data on every call
  List<JobModel>? _cachedJobs;

  /// Fetch all jobs
  /// Returns a sorted list of jobs by posted date (newest first)
  Future<List<JobModel>> getJobs() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (_cachedJobs != null) {
      return List.from(_cachedJobs!);
    }

    final jobs = _mockJobs();
    jobs.sort((a, b) => b.postedAt.compareTo(a.postedAt));

    _cachedJobs = jobs;
    return List.from(jobs);
  }

  /// Fetch a single job by ID
  /// Throws [JobNotFoundException] if job is not found
  Future<JobModel> getJobById(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Ensure data is loaded
    final jobs = await getJobs();

    try {
      return jobs.firstWhere((job) => job.id == id);
    } catch (_) {
      throw JobNotFoundException('Lowongan dengan ID $id tidak ditemukan');
    }
  }

  /// Clear cache (useful for refresh)
  void clearCache() {
    _cachedJobs = null;
  }

  // ===== MOCK DATA =====
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
        applyUrl: "mailto:nagasa.anandes@gmail.com",
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
        applyUrl: "https://stockbit.com",
      ),
    ];
  }
}

/// Custom exception for when a job is not found
class JobNotFoundException implements Exception {
  final String message;
  JobNotFoundException(this.message);

  @override
  String toString() => message;
}
