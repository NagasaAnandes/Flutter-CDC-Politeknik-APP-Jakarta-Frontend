import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../onboarding_cubit.dart';
import '../onboarding_state.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (prev, curr) => prev.pageIndex != curr.pageIndex,
      builder: (context, state) {
        final index = state.pageIndex;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            final isActive = i == index;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        );
      },
    );
  }
}
