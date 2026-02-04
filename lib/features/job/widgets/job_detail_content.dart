import 'package:flutter/material.dart';

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

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
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

              if (job.posterUrl != null) ...[
                OutlinedButton.icon(
                  icon: const Icon(Icons.image_outlined),
                  label: const Text('Lihat Poster Lowongan'),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => SafeArea(
                        child: PosterViewer(posterUrl: job.posterUrl!),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],

              Text('Deskripsi Pekerjaan', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(_dummyDescription(job), style: theme.textTheme.bodyMedium),
            ],
          ),
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
