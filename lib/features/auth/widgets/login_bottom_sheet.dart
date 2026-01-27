import 'package:flutter/material.dart';

import 'login_form.dart';

class LoginBottomSheet extends StatelessWidget {
  final VoidCallback onSuccess;

  const LoginBottomSheet({super.key, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Login diperlukan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              LoginForm(
                onSuccess: () {
                  Navigator.of(context).pop();
                  onSuccess();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
