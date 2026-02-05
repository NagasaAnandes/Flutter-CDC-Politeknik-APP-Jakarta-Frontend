import 'package:flutter/material.dart';
import 'app_breakpoint.dart';

enum LayoutType { home, detail }

class AppLayoutConfig {
  final double horizontalPadding;
  final double maxWidth;

  const AppLayoutConfig({
    required this.horizontalPadding,
    required this.maxWidth,
  });

  factory AppLayoutConfig.of(BuildContext context, {required LayoutType type}) {
    final width = MediaQuery.of(context).size.width;

    switch (type) {
      case LayoutType.home:
        if (width >= AppBreakpoint.desktop) {
          return const AppLayoutConfig(horizontalPadding: 32, maxWidth: 900);
        } else if (width >= AppBreakpoint.tablet) {
          return const AppLayoutConfig(horizontalPadding: 24, maxWidth: 900);
        }
        return const AppLayoutConfig(
          horizontalPadding: 16,
          maxWidth: double.infinity,
        );

      case LayoutType.detail:
        if (width >= AppBreakpoint.desktop) {
          return const AppLayoutConfig(horizontalPadding: 32, maxWidth: 900);
        } else if (width >= AppBreakpoint.tablet) {
          return const AppLayoutConfig(horizontalPadding: 24, maxWidth: 900);
        }
        return const AppLayoutConfig(
          horizontalPadding: 16,
          maxWidth: double.infinity,
        );
    }
  }
}
