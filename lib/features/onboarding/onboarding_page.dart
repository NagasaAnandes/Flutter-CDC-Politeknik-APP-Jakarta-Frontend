import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'onboarding_cubit.dart';
import 'onboarding_state.dart';

import 'widgets/onboarding_indicator.dart';
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

  static const int _totalPages = 3;

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

  void _onCtaPressed(BuildContext context, int pageIndex) {
    if (pageIndex == _totalPages - 1) {
      context.read<OnboardingCubit>().completeOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (prev, curr) =>
          curr is OnboardingCompleted && prev is! OnboardingCompleted,
      listener: (context, state) {
        context.goNamed('home');
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // ================= CONTENT =================
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: context.read<OnboardingCubit>().onPageChanged,
                  children: const [
                    _OnboardingSlideWrapper(child: OnboardingSlide1()),
                    _OnboardingSlideWrapper(child: OnboardingSlide2()),
                    _OnboardingSlideWrapper(child: OnboardingSlide3()),
                  ],
                ),
              ),

              // ================= INDICATOR =================
              const SizedBox(height: 8),
              const OnboardingIndicator(),
              const SizedBox(height: 16),

              // ================= FIXED CTA =================
              BlocBuilder<OnboardingCubit, OnboardingState>(
                buildWhen: (prev, curr) => prev.pageIndex != curr.pageIndex,
                builder: (context, state) {
                  final isLast = state.pageIndex == _totalPages - 1;

                  return Container(
                    padding: const EdgeInsets.fromLTRB(16, 48, 16, 48),

                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadiusGeometry.vertical(
                        top: Radius.circular(16),
                      ),
                      border: Border(
                        top: BorderSide(color: theme.colorScheme.outline),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            _onCtaPressed(context, state.pageIndex),
                        child: Text(isLast ? 'Mulai' : 'Lanjut'),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlideWrapper extends StatelessWidget {
  final Widget child;

  const _OnboardingSlideWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: child,
      ),
    );
  }
}
