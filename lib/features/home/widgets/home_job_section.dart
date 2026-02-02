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
    final theme = Theme.of(context);

    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state is JobLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // ===== HAS DATA =====
        if (state is JobLoaded && state.jobs.isNotEmpty) {
          final preview = state.jobs.take(3).toList();
          final showSeeAll = state.jobs.length > 3;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== SECTION HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pekerjaan',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (showSeeAll)
                    TextButton(
                      onPressed: () => context.go('/app/job'),
                      child: const Text('Lihat Semua'),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // ===== PREVIEW LIST =====
              ...preview.map(
                (job) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: JobCard(
                    job: job,
                    onTap: () {
                      context.go('/app/job/${job.id}', extra: job);
                    },
                  ),
                ),
              ),
            ],
          );
        }

        // ===== EMPTY STATE =====
        if (state is JobLoaded && state.jobs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Belum ada lowongan pekerjaan tersedia.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
