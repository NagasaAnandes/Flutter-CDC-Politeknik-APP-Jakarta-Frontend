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
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is EventLoaded && state.events.isNotEmpty) {
          final preview = state.events.take(3).toList();
          final showSeeAll = state.events.length > 3;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Event',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (showSeeAll)
                      TextButton(
                        onPressed: () => context.go('/app/event'),
                        child: const Text('Lihat Semua'),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ===== PREVIEW LIST =====
              ...preview.map(
                (event) => EventCard(
                  event: event,
                  onTap: () {
                    context.go('/app/event/${event.id}', extra: event);
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
