import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shell_cubit.dart';
import 'shell_state.dart';

import '../home/home_page.dart';
import '../job/job_page.dart';
import '../event/event_page.dart';
import '../profile/profile_page.dart';

class ShellPage extends StatelessWidget {
  const ShellPage({super.key});

  static const _pages = [HomePage(), JobPage(), EventPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShellCubit(),
      child: BlocBuilder<ShellCubit, ShellState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(index: state.index, children: _pages),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.index,
              onTap: context.read<ShellCubit>().changeTab,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work_outline),
                  activeIcon: Icon(Icons.work),
                  label: 'Job',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event_outlined),
                  activeIcon: Icon(Icons.event),
                  label: 'Event',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
