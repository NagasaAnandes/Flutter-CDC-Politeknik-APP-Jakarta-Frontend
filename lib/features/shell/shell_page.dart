import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellPage extends StatefulWidget {
  final Widget child;

  const ShellPage({super.key, required this.child});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    int currentIndex = 0;

    if (location.startsWith('/app/job')) currentIndex = 1;
    if (location.startsWith('/app/event')) currentIndex = 2;
    if (location.startsWith('/app/profile') ||
        location.startsWith('/app/bookmark')) {
      currentIndex = 3;
    }

    // 🔥 CRITICAL FIX: Wrap with ScaffoldMessenger to isolate SnackBar context
    // This prevents nested Scaffold issues with SnackBarAction auto-dismiss
    return ScaffoldMessenger(
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: SafeArea(
          top: false,
          bottom: false,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,

            // 🔒 VISUAL LOCK
            backgroundColor: colorScheme.surfaceContainerHighest, // PUTIH
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.primary.withValues(
              alpha: 160,
            ), // 60%

            elevation: 0, // ⬅️ PENTING (walau default)
            selectedFontSize: 12,
            unselectedFontSize: 12,
            iconSize: 24,

            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/app');
                  break;
                case 1:
                  context.go('/app/job');
                  break;
                case 2:
                  context.go('/app/event');
                  break;
                case 3:
                  context.go('/app/profile');
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.work_outline),
                activeIcon: Icon(Icons.work),
                label: 'Pekerjaan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_outlined),
                activeIcon: Icon(Icons.event),
                label: 'Event',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
