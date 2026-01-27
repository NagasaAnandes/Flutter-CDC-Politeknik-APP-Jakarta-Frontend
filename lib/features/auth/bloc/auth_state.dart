import 'package:flutter_cdc_poltek_app_frontend/features/auth/auth.dart';

abstract class AuthState {
  const AuthState();
}

class AuthGuest extends AuthState {
  const AuthGuest();
}

class AuthAuthenticated extends AuthState {
  final AuthUser user;

  const AuthAuthenticated(this.user);
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}
