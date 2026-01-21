class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final DateTime postedAt;

  const JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.postedAt,
  });
}
