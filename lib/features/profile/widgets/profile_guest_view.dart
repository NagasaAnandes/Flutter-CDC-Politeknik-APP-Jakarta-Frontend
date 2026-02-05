import 'package:flutter/material.dart';
import '../../auth/pages/login_page.dart';

class ProfileGuestView extends StatelessWidget {
  const ProfileGuestView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person_outline,
            size: 72,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Masuk untuk mengakses fitur personal',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const LoginPage()));
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
