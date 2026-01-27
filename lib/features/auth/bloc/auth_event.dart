abstract class AuthEvent {
  const AuthEvent();
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class AuthLoginRequested extends AuthEvent {
  final String identifier;

  const AuthLoginRequested({required this.identifier});
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
