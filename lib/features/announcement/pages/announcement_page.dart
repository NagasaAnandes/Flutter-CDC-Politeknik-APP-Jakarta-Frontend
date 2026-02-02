import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/announcement_cubit.dart';
import '../bloc/announcement_state.dart';
import '../widgets/announcement_card.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  double _horizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 900) {
      return 32; // tablet landscape
    } else if (width >= 600) {
      return 24; // tablet portrait
    } else {
      return 16; // mobile
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        title: Text(
          'Pengumuman',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.go('/app');
          },
        ),
      ),

      body: BlocBuilder<AnnouncementCubit, AnnouncementState>(
        builder: (context, state) {
          // ===== LOADING =====
          if (state.isLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          // ===== HAS DATA =====
          if (state.items.isNotEmpty) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 840),
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    _horizontalPadding(context),
                    16,
                    _horizontalPadding(context),
                    16,
                  ),
                  itemCount: state.items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return AnnouncementCard(item: state.items[index]);
                  },
                ),
              ),
            );
          }

          // ===== EMPTY STATE =====
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.campaign_outlined,
                    size: 48,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada pengumuman',
                    style: textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
