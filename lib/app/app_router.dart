import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/splash_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/home/home_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
  ],
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text('Halaman tidak ditemukan'))),
);
