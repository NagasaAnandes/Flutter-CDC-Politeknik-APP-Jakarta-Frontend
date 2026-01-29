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
                // ===== SEARCH BAR =====
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppSearchBar(
                    hintText: 'Cari lowongan',
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() => _query = value);
                    },
                  ),
                ),

                // ===== LIST / EMPTY =====
                Expanded(
                  child: filteredJobs.isEmpty
                      ? _query.isEmpty
                            ? const JobEmptyView()
                            : const _SearchEmptyView(
                                message: 'Lowongan tidak ditemukan',
                              )
                      : JobList(jobs: filteredJobs),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 64),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
