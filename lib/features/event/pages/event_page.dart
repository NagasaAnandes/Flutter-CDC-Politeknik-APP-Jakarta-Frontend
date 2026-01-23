import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/event/bloc/event_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/event/bloc/event_state.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/event/widgets/event_empty.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/event/widgets/event_list.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event')),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EventLoaded) {
            if (state.events.isEmpty) {
              return const EventEmptyView();
            }
            return EventList(events: state.events);
          }

          if (state is EventError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
