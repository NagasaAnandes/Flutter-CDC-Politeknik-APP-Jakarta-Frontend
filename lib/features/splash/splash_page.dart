import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'splash_cubit.dart';
import 'splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..checkAppState(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToOnboarding) {
            context.goNamed('onboarding');
          } else if (state is SplashNavigateToHome) {
            context.goNamed('home');
          }
        },
        child: const _SplashView(),
      ),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Image.asset(
                'assets/images/Logo_Politeknik_APP.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 24),

              // App / Institution Name
              Text(
                'CDC Politeknik APP Jakarta',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Tagline / Helper
              Text(
                'Career Development Center',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
