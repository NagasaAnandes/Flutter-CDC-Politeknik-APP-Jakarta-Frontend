import 'package:flutter/material.dart';

class OnboardingSlide1 extends StatelessWidget {
  const OnboardingSlide1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final isTablet = height >= 700;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // ===== FLEX TOP =====
              const Spacer(flex: 2),

              // ===== HERO IMAGE =====
              Image.asset(
                'assets/images/Mahasiswa_1.png',
                height: isTablet ? 260 : 220,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 32),

              // ===== TITLE =====
              Text(
                'Official Career Gateway',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // ===== SUBTITLE =====
              Text(
                'Politeknik APP Jakarta',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),

              // ===== FLEX BOTTOM =====
              const Spacer(flex: 3),
            ],
          ),
        );
      },
    );
  }
}
