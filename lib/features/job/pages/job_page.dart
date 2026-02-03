import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/search_bar.dart';
import '../bloc/job_bloc.dart';
import '../bloc/job_state.dart';
import '../widgets/job_list.dart';
import '../widgets/job_empty_view.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  double _horizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 32;
    if (width >= 600) return 24;
    return 16;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lowongan'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is JobLoaded) {
            final jobs = state.jobs;

            // ===== FILTER LOGIC (LOCAL SEARCH) =====
            final filteredJobs = jobs.where((job) {
              final keyword = _query.toLowerCase();
              return job.title.toLowerCase().contains(keyword) ||
                  job.company.toLowerCase().contains(keyword) ||
                  job.location.toLowerCase().contains(keyword);
            }).toList();

            return Column(
              children: [
                // ================= SEARCH SECTION =================
                Container(
                  padding: EdgeInsets.fromLTRB(
                    _horizontalPadding(context),
                    16,
                    _horizontalPadding(context),
                    16,
                  ),
                  color: colorScheme.surfaceContainerHighest,
                  child: AppSearchBar(
                    hintText: 'Cari lowongan',
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() => _query = value);
                    },
                  ),
                ),

                // ================= CONTENT =================
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: _horizontalPadding(context),
                        ),
                        child: filteredJobs.isEmpty
                            ? _query.isEmpty
                                  ? const JobEmptyView()
                                  : const _SearchEmptyView(
                                      message: 'Lowongan tidak ditemukan',
                                    )
                            : JobList(jobs: filteredJobs),
                      ),
                    ),
                  ),
                ),
              ],
            );
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

class _SearchEmptyView extends StatelessWidget {
  final String message;

  const _SearchEmptyView({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
