import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';

typedef AuthenticatedCallback = void Function();

void requireAuth(
  BuildContext context, {
  required AuthenticatedCallback onAuthenticated,
  VoidCallback? onUnauthenticated,
}) {
  final authState = context.read<AuthBloc>().state;

  if (authState is AuthAuthenticated) {
    onAuthenticated();
  } else {
    onUnauthenticated?.call();
  }
}
