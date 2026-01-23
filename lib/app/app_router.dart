import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/announcement/pages/announcement_page.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/job/models/job_model.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/job/pages/job_detail_page.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/splash_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/shell/shell_page.dart';
import '../features/home/home_page.dart';
import '../features/job/pages/job_page.dart';
import '../features/event/event_page.dart';
import '../features/profile/profile_page.dart';
import '../features/announcement/bloc/announcement_cubit.dart';
import '../features/job/bloc/job_bloc.dart';
import '../features/job/bloc/job_event.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

Widget buildAppWithProviders({required Widget child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<AnnouncementCubit>(
        create: (context) => AnnouncementCubit()..loadAnnouncements(),
      ),
      BlocProvider<JobBloc>(create: (context) => JobBloc()..add(LoadJobs())),
    ],
    child: child,
  );
}

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    /// ===== Splash =====
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),

    /// ===== Onboarding =====
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),

    /// ===== Main App (Bottom Navigation Shell) =====
    ShellRoute(
      builder: (context, state, child) {
        return ShellPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/app',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/app/job',
          name: 'job',
          builder: (context, state) => const JobPage(),
          routes: [
            GoRoute(
              path: ':id',
              name: 'jobDetail',
              builder: (context, state) {
                final job = state.extra as JobModel;
                return JobDetailPage(job: job);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/app/event',
          name: 'event',
          builder: (context, state) => const EventPage(),
        ),
        GoRoute(
          path: '/app/profile',
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/app/announcement',
          name: 'announcement',
          builder: (context, state) => const AnnouncementPage(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text('Halaman tidak ditemukan'))),
);
