import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/services/auth_local_services.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLocalService authService;

  AuthBloc({required this.authService}) : super(const AuthGuest()) {
    on<AuthStarted>((event, emit) async {
      final user = await authService.loadUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthGuest());
      }
    });

    on<AuthLoginRequested>((event, emit) async {
      final user = await authService.login(event.identifier);
      emit(AuthAuthenticated(user));
    });

    on<AuthLogoutRequested>((event, emit) async {
      await authService.logout();
      emit(const AuthGuest());
    });
  }
}
