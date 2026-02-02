import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../announcement/bloc/announcement_cubit.dart';
import '../../announcement/bloc/announcement_state.dart';
import '../../announcement/widgets/announcement_card.dart';

class HomeAnnouncementSection extends StatelessWidget {
  const HomeAnnouncementSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          final preview = state.items.take(2).toList();
          final showSeeAll = state.items.length > 2;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== SECTION HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pengumuman',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (showSeeAll)
                    TextButton(
                      onPressed: () => context.push('/announcement'),
                      child: const Text('Lihat Semua'),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // ===== PREVIEW LIST =====
              ...preview.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AnnouncementCard(item: item),
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
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        );
      },
    );
  }
}
