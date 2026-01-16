import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/splash_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/shell/shell_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    /// Splash
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),

    /// Onboarding
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),

    /// Main App Shell (Bottom Navigation)
    GoRoute(
      path: '/app',
      name: 'app',
      builder: (context, state) => const ShellPage(),
    ),
  ],
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text('Halaman tidak ditemukan'))),
);
