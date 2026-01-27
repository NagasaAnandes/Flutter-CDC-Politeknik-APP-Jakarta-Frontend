import 'package:flutter_cdc_poltek_app_frontend/features/auth/auth.dart';

import '../../../services/local_storage_service.dart';
import '../../../core/constants/storage_keys.dart';

class AuthLocalService {
  final LocalStorageService _storage = LocalStorageService();

  /// Login dummy + persist
  Future<AuthUser> login(String identifier) async {
    final user = AuthUser(
      id: identifier.hashCode.toString(),
      displayName: identifier,
    );

    await _storage.setString(StorageKeys.authUserId, user.id);
    await _storage.setString(StorageKeys.authUserName, user.displayName);

    return user;
  }

  /// Load user on app start
  Future<AuthUser?> loadUser() async {
    final id = await _storage.getString(StorageKeys.authUserId);
    final name = await _storage.getString(StorageKeys.authUserName);

    if (id == null || name == null) return null;

    return AuthUser(id: id, displayName: name);
  }

  /// Logout
  Future<void> logout() async {
    await _storage.remove(StorageKeys.authUserId);
    await _storage.remove(StorageKeys.authUserName);
  }
}
