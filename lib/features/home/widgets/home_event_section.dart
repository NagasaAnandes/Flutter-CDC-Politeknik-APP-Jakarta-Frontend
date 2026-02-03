import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../event/bloc/event_bloc.dart';
import '../../event/bloc/event_state.dart';
import '../../event/widgets/event_card.dart';

class HomeEventSection extends StatelessWidget {
  const HomeEventSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // ===== HAS DATA =====
        if (state is EventLoaded && state.events.isNotEmpty) {
          final preview = state.events.take(3).toList();
          final showSeeAll = state.events.length > 3;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== SECTION HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Event',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (showSeeAll)
                    TextButton(
                      onPressed: () => context.go('/app/event'),
                      child: const Text('Lihat Semua'),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // ===== PREVIEW LIST =====
              ...preview.map(
                (event) => Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: EventCard(
                    event: event,
                    onTap: () {
                      context.go('/app/event/${event.id}', extra: event);
                    },
                  ),
                ),
              ),
            ],
          );
        }

        // ===== EMPTY STATE =====
        if (state is EventLoaded && state.events.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Belum ada event yang akan datang.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
