import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../job/bloc/job_bloc.dart';
import '../../job/bloc/job_state.dart';
import '../../job/widgets/job_card.dart';

class HomeJobSection extends StatelessWidget {
  const HomeJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state is JobLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is JobLoaded && state.jobs.isNotEmpty) {
          final preview = state.jobs.take(3).toList();
          final showSeeAll = state.jobs.length > 3;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER (KONSISTEN) =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pekerjaan',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (showSeeAll)
                      TextButton(
                        onPressed: () => context.go('/app/job'),
                        child: const Text('Lihat Semua'),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ===== PREVIEW LIST =====
              ...preview.map((job) => JobCard(job: job)),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
