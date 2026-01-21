import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/job_bloc.dart';
import 'bloc/job_state.dart';
import 'widgets/job_list.dart';
import 'widgets/job_empty_view.dart';

class JobPage extends StatelessWidget {
  const JobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lowongan')),
      body: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is JobLoaded) {
            if (state.jobs.isEmpty) {
              return const JobEmptyView();
            }
            return JobList(jobs: state.jobs);
          }

          if (state is JobError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
