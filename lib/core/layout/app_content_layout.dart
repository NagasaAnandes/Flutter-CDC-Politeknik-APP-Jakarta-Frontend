import 'package:flutter/material.dart';
import 'app_layout_config.dart';

class AppContentLayout extends StatelessWidget {
  final Widget child;
  final LayoutType type;
  final EdgeInsets? extraPadding;

  const AppContentLayout({
    super.key,
    required this.child,
    required this.type,
    this.extraPadding,
  });

  @override
  Widget build(BuildContext context) {
    final config = AppLayoutConfig.of(context, type: type);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: config.maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: config.horizontalPadding,
          ).add(extraPadding ?? EdgeInsets.zero),
          child: child,
        ),
      ),
    );
  }
}
