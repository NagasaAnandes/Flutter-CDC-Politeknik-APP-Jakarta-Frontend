import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/job_model.dart';
import 'job_card.dart';

class JobList extends StatelessWidget {
  final List<JobModel> jobs;

  const JobList({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return JobCard(
          job: job,
          onTap: () {
            context.go('/app/job/${job.id}', extra: job);
          },
        );
      },
    );
  }
}
