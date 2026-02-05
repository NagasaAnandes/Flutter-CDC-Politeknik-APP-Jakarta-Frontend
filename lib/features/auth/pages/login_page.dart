import 'package:flutter/material.dart';

import '../../../core/layout/app_content_layout.dart';
import '../../../core/layout/app_layout_config.dart';

import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: AppContentLayout(
        type: LayoutType.detail, // pakai padding sistem
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: LoginForm(
              onSuccess: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
    );
  }
}
