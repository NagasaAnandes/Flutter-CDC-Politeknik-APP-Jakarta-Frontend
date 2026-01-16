import 'package:flutter/material.dart';

class OnboardingHeroSlide extends StatelessWidget {
  final String heroImage;
  final String title;
  final String description;
  final Widget cta;

  const OnboardingHeroSlide({
    super.key,
    required this.heroImage,
    required this.title,
    required this.description,
    required this.cta,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        final heroHeight = (height * 0.30).clamp(140.0, 320.0);
        final cardHeight = (height * 0.40).clamp(220.0, 420.0);

        return Column(
          children: [
            const Spacer(),

            SizedBox(
              height: heroHeight + cardHeight * 0.85,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Bottom card
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 12,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: cardHeight * 0.6,
                          maxHeight: cardHeight,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              description,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: SafeArea(top: false, child: cta),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Hero image
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Center(
                      child: Image.asset(
                        heroImage,
                        height: heroHeight,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
