import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/core/widgets/detail_bottom_bar.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/job/bloc/job_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/job/bloc/job_state.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/job/widgets/job_detail_content.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/bookmark_service.dart';
import '../../../core/utils/app_tracker.dart';

import '../../bookmark/models/bookmark_item.dart';
import '../../notification/models/notification_item.dart';
import '../../notification/services/notification_service.dart';

import '../bloc/job_detail_bloc.dart';
import '../bloc/job_detail_event.dart';
import '../models/job_model.dart';

class JobDetailPage extends StatefulWidget {
  final String jobId;

  const JobDetailPage({super.key, required this.jobId});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();

    context.read<JobDetailBloc>().add(LoadJobDetail(widget.jobId));

    _loadBookmark();
  }

  Future<void> _loadBookmark() async {
    final value = await BookmarkService.isBookmarked(widget.jobId);
    if (!mounted) return;
    setState(() => _isBookmarked = value);
  }

  Future<void> _toggleBookmark(JobModel job) async {
    final bookmarked = await BookmarkService.toggleBookmark(
      BookmarkItem(
        id: job.id,
        type: 'job',
        title: job.title,
        subtitle: job.company,
      ),
    );

    if (!mounted) return;
    setState(() => _isBookmarked = bookmarked);

    if (bookmarked) {
      await NotificationService.add(
        NotificationItem(
          id: DateTime.now().toIso8601String(),
          type: NotificationType.job,
          title: 'Lowongan disimpan',
          body: '${job.title} di ${job.company} ditambahkan ke bookmark',
          createdAt: DateTime.now(),
          isRead: false,
          referenceId: job.id,
        ),
      );
    }
  }

  Future<void> _applyJob(JobModel job) async {
    AppTracker.trackJobApply(
      jobId: job.id,
      company: job.company,
      applyUrl: job.applyUrl,
    );

    final uri = Uri.parse(job.applyUrl);
    final success = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka tautan pendaftaran')),
      );
      return;
    }

    await NotificationService.add(
      NotificationItem(
        id: DateTime.now().toIso8601String(),
        type: NotificationType.job,
        title: 'Lamaran dikirim',
        body: 'Kamu mengunjungi halaman lamaran ${job.title}',
        createdAt: DateTime.now(),
        isRead: false,
        referenceId: job.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        title: const Text('Detail Pekerjaan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),

      // ===== BODY (SCROLL DI SINI) =====
      body: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoaded) {
            final job = state.jobs.firstWhere((j) => j.id == widget.jobId);

            return Column(
              children: [
                // 🔥 SCROLLABLE CONTENT
                Expanded(child: JobDetailContent(job: job)),

                // 🔥 FIXED CTA
                DetailBottomBar(
                  isSecondaryActive: _isBookmarked,
                  onSecondaryAction: () => _toggleBookmark(job),
                  onPrimaryAction: () => _applyJob(job),
                  primaryLabel: 'Kunjungi Informasi Pendaftaran',
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
