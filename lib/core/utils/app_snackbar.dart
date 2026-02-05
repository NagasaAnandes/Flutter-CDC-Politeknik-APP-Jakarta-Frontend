import 'package:flutter/material.dart';
import '../../app/app_router.dart';

class AppSnackBar {
  static void show(SnackBar snackBar) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(snackBar);
  }
}
