import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/core/widgets/search_empty_view.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/job/bloc/job_event.dart';

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
  void initState() {
    super.initState();
    context.read<JobBloc>().add(LoadJobs());
  }

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
            final filteredJobs = state.jobs.where((job) {
              final keyword = _query.toLowerCase();
              return job.title.toLowerCase().contains(keyword) ||
                  job.company.toLowerCase().contains(keyword) ||
                  job.location.toLowerCase().contains(keyword);
            }).toList();

            return Column(
              children: [
                // ================= SEARCH SECTION =================
                Container(
                  width: double.infinity,
                  color: colorScheme.surfaceContainerHighest,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: _horizontalPadding(context),
                        ),
                        child: AppSearchBar(
                          hintText: 'Cari lowongan',
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() => _query = value);
                          },
                        ),
                      ),
                    ),
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
                                  : const SearchEmptyView(
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
