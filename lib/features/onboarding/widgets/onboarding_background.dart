import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  final String image;
  final Widget child;

  const OnboardingBackground({
    super.key,
    required this.image,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(image, fit: BoxFit.cover),

        // Gradient overlay (optimized for bottom card readability)
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.0, 0.35, 0.65, 1.0],
              colors: [
                Color(0xE6000000), // 90% black
                Color(0x99000000), // 60%
                Color(0x33000000), // 20%
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Foreground content only
        SafeArea(bottom: false, child: child),
      ],
    );
  }
}
