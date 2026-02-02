import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/announcement_cubit.dart';
import '../bloc/announcement_state.dart';
import 'announcement_card.dart';

class AnnouncementSection extends StatelessWidget {
  final VoidCallback? onSeeAll;

  const AnnouncementSection({super.key, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return BlocBuilder<AnnouncementCubit, AnnouncementState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // ===== HAS DATA =====
        if (state.items.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pengumuman',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (onSeeAll != null)
                    InkWell(
                      onTap: onSeeAll,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          'Lihat Semua',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // ===== LIST =====
              ...state.items.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AnnouncementCard(item: e),
                ),
              ),
            ],
          );
        }

        // ===== EMPTY STATE =====
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Belum ada pengumuman terbaru.',
            style: textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        );
      },
    );
  }
}
