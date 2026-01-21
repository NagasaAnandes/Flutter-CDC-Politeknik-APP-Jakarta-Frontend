import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'onboarding_cubit.dart';
import 'onboarding_state.dart';

import 'widgets/onboarding_slide_1.dart';
import 'widgets/onboarding_slide_2.dart';
import 'widgets/onboarding_slide_3.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (prev, curr) =>
          curr is OnboardingCompleted && prev is! OnboardingCompleted,
      listener: (context, state) {
        // ✅ SINGLE EXIT POINT
        context.goNamed('home'); // == /app
      },
      child: PageView(
        controller: _pageController,
        onPageChanged: context.read<OnboardingCubit>().onPageChanged,
        children: [
          OnboardingSlide1(
            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          OnboardingSlide2(
            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          OnboardingSlide3(
            onFinish: () {
              // ❌ UI TIDAK NAVIGASI
              // ✅ UI HANYA EMIT INTENT
              context.read<OnboardingCubit>().completeOnboarding();
            },
          ),
        ],
      ),
    );
  }
}
