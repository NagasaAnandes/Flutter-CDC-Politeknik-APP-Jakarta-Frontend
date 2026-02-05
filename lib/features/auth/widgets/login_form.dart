import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onSuccess;

  const LoginForm({super.key, required this.onSuccess});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final identifier = _identifierController.text.trim();
    final password = _passwordController.text;

    if (identifier.isEmpty || password.isEmpty) return;

    // NOTE: tetap pakai event lama (password belum dipakai)
    context.read<AuthBloc>().add(AuthLoginRequested(identifier: identifier));

    widget.onSuccess();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ===== TITLE =====
        Text(
          'Masuk',
          style: theme.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Gunakan akun kamu untuk melanjutkan',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        // ===== IDENTIFIER =====
        TextField(
          controller: _identifierController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'NIM',
            hintText: 'contoh: 2123xxxxx',
          ),
        ),

        const SizedBox(height: 16),

        // ===== PASSWORD =====
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              tooltip: _obscurePassword
                  ? 'Tampilkan password'
                  : 'Sembunyikan password',
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ===== CTA =====
        SizedBox(
          height: 48,
          child: ElevatedButton(onPressed: _submit, child: const Text('Login')),
        ),
      ],
    );
  }
}
