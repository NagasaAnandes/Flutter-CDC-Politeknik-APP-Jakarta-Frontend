import 'package:flutter/material.dart';
import 'package:flutter_cdc_poltek_app_frontend/core/widgets/company_avatar.dart';
import 'package:flutter_cdc_poltek_app_frontend/core/widgets/meta_item.dart';
import '../models/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;

  const JobCard({super.key, required this.job, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.4)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== COMPANY AVATAR =====
              CompanyAvatar(company: job.company, logoUrl: job.companyLogoUrl),

              const SizedBox(width: 12),

              // ===== CONTENT =====
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== JOB TITLE =====
                    Text(
                      job.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // ===== COMPANY + META =====
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          job.company,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),

                        if (job.isPartner)
                          Icon(
                            Icons.verified,
                            size: 14,
                            color: colorScheme.primary,
                          ),

                        Text(
                          '• ${job.location}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ===== METADATA =====
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        MetaItem(
                          icon: Icons.work_outline,
                          label: job.experience,
                        ),
                        MetaItem(
                          icon: Icons.school_outlined,
                          label: job.education,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
