import 'package:flutter/material.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/auth_guard.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/widgets/login_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/app_tracker.dart';
import '../../../core/services/bookmark_service.dart';

import '../models/job_model.dart';
import '../widgets/company_avatar.dart';
import '../widgets/meta_item.dart';
import '../widgets/job_poster.dart';

class JobDetailPage extends StatefulWidget {
  final JobModel job;

  const JobDetailPage({super.key, required this.job});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  bool _isBookmarked = false;
  @override
  void initState() {
    super.initState();
    _loadBookmark();
  }

  Future<void> _loadBookmark() async {
    final value = await BookmarkService.isBookmarked(widget.job.id);
    if (!mounted) return;
    setState(() => _isBookmarked = value);
  }

  Future<void> _toggleBookmark() async {
    final value = await BookmarkService.toggleBookmark(widget.job.id);
    if (!mounted) return;
    setState(() => _isBookmarked = value);
  }

  Future<void> _applyJob() async {
    // ===== TRACKING =====
    AppTracker.trackJobApply(
      jobId: widget.job.id,
      company: widget.job.company,
      applyUrl: widget.job.applyUrl,
    );

    final uri = Uri.parse(widget.job.applyUrl);

    final success = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka tautan pendaftaran')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pekerjaan')),

      // ===== BODY =====
      body: SingleChildScrollView(
        // padding bawah DITAMBAH supaya tidak ketutup bottom bar
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== HEADER =====
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CompanyAvatar(
                  company: widget.job.company,
                  logoUrl: widget.job.companyLogoUrl,
                  size: 56,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.job.title,
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.job.company,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          if (widget.job.isPartner) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.verified,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.job.location,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // ===== META =====
            Row(
              children: [
                MetaItem(
                  icon: Icons.work_outline,
                  label: widget.job.experience,
                ),
                const SizedBox(width: 24),
                MetaItem(
                  icon: Icons.school_outlined,
                  label: widget.job.education,
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // ===== JOB POSTER (OPTIONAL) =====
            if (widget.job.posterUrl != null) ...[
              OutlinedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) {
                      return SafeArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: JobPoster(posterUrl: widget.job.posterUrl!),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.image_outlined),
                label: const Text('Lihat Poster Lowongan'),
              ),
              const SizedBox(height: 16),
            ],

            // ===== DESCRIPTION =====
            Text('Deskripsi Pekerjaan', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              _dummyDescription(widget.job),
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),

      // ===== BOTTOM ACTION BAR (PERMANEN) =====
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // ===== BOOKMARK (DUMMY) =====
              OutlinedButton(
                onPressed: () {
                  requireAuth(
                    context,
                    onAuthenticated: _toggleBookmark,
                    onUnauthenticated: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) =>
                            LoginBottomSheet(onSuccess: _toggleBookmark),
                      );
                    },
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(48, 48),
                  padding: EdgeInsets.zero,
                ),
                child: Icon(
                  _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                ),
              ),

              const SizedBox(width: 12),

              // ===== APPLY BUTTON =====
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    requireAuth(
                      context,
                      onAuthenticated: _applyJob,
                      onUnauthenticated: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) =>
                              LoginBottomSheet(onSuccess: _applyJob),
                        );
                      },
                    );
                  },
                  child: const Text('Kunjungi Informasi Pendaftaran'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _dummyDescription(JobModel job) {
    return 'Politeknik APP Jakarta membuka kesempatan bagi lulusan terbaik '
        'untuk bergabung sebagai ${job.title} di ${job.company}. '
        'Posisi ini berlokasi di ${job.location} dan terbuka bagi kandidat '
        'dengan kualifikasi yang sesuai.\n\n'
        'Informasi lebih lanjut mengenai proses rekrutmen '
        'akan disampaikan oleh pihak perusahaan.';
  }
}
