import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ===== CORE / APP =====
import '../features/splash/splash_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/shell/shell_page.dart';
import '../features/home/home_page.dart';

// ===== ANNOUNCEMENT =====
import '../features/announcement/pages/announcement_page.dart';
import '../features/announcement/bloc/announcement_cubit.dart';

// ===== JOB =====
import '../features/job/pages/job_page.dart';
import '../features/job/pages/job_detail_page.dart';
import '../features/job/models/job_model.dart';
import '../features/job/bloc/job_bloc.dart';
import '../features/job/bloc/job_event.dart';

// ===== EVENT =====
import '../features/event/pages/event_page.dart';
import '../features/event/pages/event_detail_page.dart';
import '../features/event/models/event_model.dart';
import '../features/event/bloc/event_bloc.dart';
import '../features/event/bloc/event_event.dart';

// ===== PROFILE =====
import '../features/profile/profile_page.dart';

// ===== AUTH (BUSINESS ONLY, NO UI) =====
import '../features/auth/bloc/auth_bloc.dart';
import '../features/auth/bloc/auth_event.dart';
import '../features/auth/services/auth_local_services.dart';

/// Root navigator (dibutuhkan untuk dialog / bottom sheet nanti)
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// =============================================================
/// GLOBAL BLOC PROVIDERS
/// =============================================================
Widget buildAppWithProviders({required Widget child}) {
  return MultiBlocProvider(
    providers: [
      /// ===== AUTH (GLOBAL) =====
      BlocProvider<AuthBloc>(
        create: (_) =>
            AuthBloc(authService: AuthLocalService())..add(const AuthStarted()),
      ),

      /// ===== ANNOUNCEMENT =====
      BlocProvider<AnnouncementCubit>(
        create: (_) => AnnouncementCubit()..loadAnnouncements(),
      ),

      /// ===== JOB =====
      BlocProvider<JobBloc>(create: (_) => JobBloc()..add(LoadJobs())),

      /// ===== EVENT =====
      BlocProvider<EventBloc>(
        create: (_) => EventBloc()..add(const LoadEvents()),
      ),
    ],
    child: child,
  );
}

/// =============================================================
/// APP ROUTER
/// =============================================================
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',

  routes: [
    /// ================= SPLASH =================
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),

    /// ================= ONBOARDING =================
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),

    /// ================= MAIN APP (SHELL) =================
    ShellRoute(
      builder: (context, state, child) {
        return ShellPage(child: child);
      },
      routes: [
        /// -------- HOME --------
        GoRoute(
          path: '/app',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),

        /// -------- JOB --------
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

        /// -------- EVENT --------
        GoRoute(
          path: '/app/event',
          name: 'event',
          builder: (context, state) => const EventPage(),
          routes: [
            GoRoute(
              path: ':id',
              name: 'eventDetail',
              builder: (context, state) {
                final event = state.extra as EventModel;
                return EventDetailPage(event: event);
              },
            ),
          ],
        ),

        /// -------- ANNOUNCEMENT --------
        GoRoute(
          path: '/app/announcement',
          name: 'announcement',
          builder: (context, state) => const AnnouncementPage(),
        ),

        /// -------- PROFILE --------
        GoRoute(
          path: '/app/profile',
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],

  errorBuilder: (context, state) {
    return const Scaffold(body: Center(child: Text('Halaman tidak ditemukan')));
  },
);
