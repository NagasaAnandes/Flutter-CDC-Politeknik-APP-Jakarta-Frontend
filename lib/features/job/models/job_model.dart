class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final DateTime postedAt;
  final String experience;
  final String education;
  final bool isPartner;
  final String applyUrl;
  final String? companyLogoUrl;
  final String? posterUrl;

  const JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.postedAt,
    required this.experience,
    required this.education,
    required this.applyUrl,
    this.isPartner = false,
    this.companyLogoUrl,
    this.posterUrl,
  });
}
