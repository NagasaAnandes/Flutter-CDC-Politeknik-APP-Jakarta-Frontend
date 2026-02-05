import 'package:flutter/material.dart';

import '../../../core/layout/app_content_layout.dart';
import '../../../core/layout/app_layout_config.dart';

import '../../../core/widgets/company_avatar.dart';
import '../../../core/widgets/meta_item.dart';
import '../../../core/widgets/poster_viewer.dart';
import '../models/job_model.dart';

class JobDetailContent extends StatelessWidget {
  final JobModel job;

  const JobDetailContent({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final metas = [
      if (job.experience.isNotEmpty) (Icons.work_outline, job.experience),
      if (job.education.isNotEmpty) (Icons.school_outlined, job.education),
    ];

    return SingleChildScrollView(
      child: AppContentLayout(
        type: LayoutType.detail,
        extraPadding: const EdgeInsets.fromLTRB(
          0,
          24,
          0,
          96,
        ), // ⬅️ aman dari CTA
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== HEADER =====
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CompanyAvatar(
                  company: job.company,
                  logoUrl: job.companyLogoUrl,
                  size: 56,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.title, style: theme.textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text(job.company, style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 4),
                      Text(job.location, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // ===== META =====
            Wrap(
              spacing: 24,
              runSpacing: 12,
              children: metas
                  .map((m) => MetaItem(icon: m.$1, label: m.$2))
                  .toList(),
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // ===== POSTER =====
            if (job.posterUrl != null) ...[
              OutlinedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => SafeArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: PosterViewer(posterUrl: job.posterUrl!),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.image_outlined),
                label: const Text('Lihat Poster Pekerjaan'),
              ),
              const SizedBox(height: 16),
            ],

            // ===== DESCRIPTION =====
            Text('Deskripsi Pekerjaan', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              _dummyDescription(job),
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }

  String _dummyDescription(JobModel job) {
    return 'Politeknik APP Jakarta membuka kesempatan bagi lulusan terbaik '
        'untuk bergabung sebagai ${job.title} di ${job.company}. '
        'Posisi ini berlokasi di ${job.location}.';
  }
}
