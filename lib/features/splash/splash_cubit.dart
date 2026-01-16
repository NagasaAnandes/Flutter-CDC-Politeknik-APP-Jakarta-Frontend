import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/storage_keys.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkAppState() async {
    emit(SplashLoading());

    // Branding delay (UX)
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final onboardingSeen = prefs.getBool(StorageKeys.onboardingSeen) ?? false;

    if (onboardingSeen) {
      emit(SplashNavigateToHome());
    } else {
      emit(SplashNavigateToOnboarding());
    }
  }
}
