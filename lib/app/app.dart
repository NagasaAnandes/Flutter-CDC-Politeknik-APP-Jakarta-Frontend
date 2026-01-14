import 'package:flutter/material.dart';

import 'app_router.dart';
import 'app_theme.dart';

class CDCApp extends StatelessWidget {
  const CDCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CDC Politeknik APP Jakarta',
      theme: AppTheme.light,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
