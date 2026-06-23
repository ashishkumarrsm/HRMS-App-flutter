import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// SecureStorageService
/// Handles all persistent secure storage for the HRMS app.
///
/// Key design decisions:
/// - All biometric data is keyed per loginId → multi-account support (Case 6)
/// - biometricInvalidated flag → detects fingerprint change (Case 2)
/// - logout clears biometric for that account only (Case 3)
/// - isLoggedIn is separate from biometricEnabled (Case 4 / multi-device)
class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // ─── Token / Session ──────────────────────────────────────────────────────

  static Future<void> saveLoginData({
    required String token,
    required String refreshToken,
    required String loginId,
  }) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'refreshToken', value: refreshToken);
    await _storage.write(key: 'isLoggedIn', value: 'true');
    await _storage.write(key: 'currentLoginId', value: loginId);
  }

  static Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: 'isLoggedIn');
    return value == 'true';
  }

  static Future<String?> getToken() async => _storage.read(key: 'token');

  static Future<String?> getRefreshToken() async =>
      _storage.read(key: 'refreshToken');

  static Future<String?> getCurrentLoginId() async =>
      _storage.read(key: 'currentLoginId');

  // ─── User Display Data ────────────────────────────────────────────────────

  static Future<void> saveUserData({
    required String firstName,
    required String lastName,
    required String loginId,
  }) async {
    // Store globally for current session display
    await _storage.write(key: 'firstName', value: firstName);
    await _storage.write(key: 'lastName', value: lastName);

    // Also store per-account so biometric login can show the right name (Case 6)
    await _storage.write(key: '${loginId}_firstName', value: firstName);
    await _storage.write(key: '${loginId}_lastName', value: lastName);
  }

  static Future<String?> getFirstName() async =>
      _storage.read(key: 'firstName');

  static Future<String?> getLastName() async => _storage.read(key: 'lastName');

  static Future<String?> getFirstNameForLoginId(String loginId) async =>
      _storage.read(key: '${loginId}_firstName');

  static Future<String?> getLastNameForLoginId(String loginId) async =>
      _storage.read(key: '${loginId}_lastName');

  // ─── Biometric — Per-Account ──────────────────────────────────────────────
  //
  // We key ALL biometric flags under the loginId so that:
  //   - Each account has its own biometric state         (Case 6)
  //   - Biometric for one account never leaks to another (Case 6)
  //
  // Additionally we track a "registered biometric key" which is the
  // platform key count at the time of enrollment. If it changes,
  // we know the user changed/added/removed fingerprints.          (Case 2)

  /// Mark that the biometric setup dialog has already been shown for this loginId.
  static Future<void> setBiometricAsked({required String loginId}) async {
    await _storage.write(key: '${loginId}_biometricAsked', value: 'true');
  }

  static Future<bool> isBiometricAsked({required String loginId}) async {
    final value = await _storage.read(key: '${loginId}_biometricAsked');
    return value == 'true';
  }

  /// Enable biometric for this loginId and record the enrollment timestamp.
  /// We use the timestamp as a lightweight "biometric version" – if the
  /// device biometrics change (Case 2), local_auth will throw a
  /// LAErrorPasscodeNotSet or similar; we rely on that + our own flag.
  static Future<void> enableBiometric({required String loginId}) async {
    await _storage.write(key: '${loginId}_biometricEnabled', value: 'true');
    await _storage.write(
      key: '${loginId}_biometricInvalidated',
      value: 'false',
    );
    // Record enrollment time so we can surface a human-readable message
    await _storage.write(
      key: '${loginId}_biometricEnrolledAt',
      value: DateTime.now().toIso8601String(),
    );
  }

  static Future<bool> isBiometricEnabled({required String loginId}) async {
    final value = await _storage.read(key: '${loginId}_biometricEnabled');
    return value == 'true';
  }

  /// Called when local_auth returns a biometricChanged / lockout error (Case 2).
  /// Disables biometric and forces re-login.
  static Future<void> invalidateBiometric({required String loginId}) async {
    await _storage.write(key: '${loginId}_biometricEnabled', value: 'false');
    await _storage.write(key: '${loginId}_biometricInvalidated', value: 'true');
    // Reset "asked" so after re-login the user gets the setup prompt again
    await _storage.write(key: '${loginId}_biometricAsked', value: 'false');
  }

  static Future<bool> isBiometricInvalidated({required String loginId}) async {
    final value = await _storage.read(key: '${loginId}_biometricInvalidated');
    return value == 'true';
  }

  /// Disable biometric cleanly (e.g. on logout).
  static Future<void> disableBiometric({required String loginId}) async {
    await _storage.write(key: '${loginId}_biometricEnabled', value: 'false');
    await _storage.write(
      key: '${loginId}_biometricInvalidated',
      value: 'false',
    );
    await _storage.write(key: '${loginId}_biometricAsked', value: 'false');
  }

  // ─── "Primary biometric account" for Case 6 ───────────────────────────────
  //
  // Only the FIRST account that enables biometric on this device is stored
  // here. If a different user tries to use biometric, we show a dialog:
  // "This device has biometric set up for <firstName>. Log in as <firstName>?"

  static Future<void> setPrimaryBiometricAccount(String loginId) async {
    await _storage.write(key: 'primaryBiometricLoginId', value: loginId);
  }

  static Future<String?> getPrimaryBiometricLoginId() async =>
      _storage.read(key: 'primaryBiometricLoginId');

  static Future<void> clearPrimaryBiometricAccount() async =>
      _storage.delete(key: 'primaryBiometricLoginId');

  // ─── Logout ───────────────────────────────────────────────────────────────

  /// Logout: clear session tokens but keep per-account biometric prefs
  /// so that if the user logs back in the state is correctly restored.
  /// The biometric for THIS loginId is explicitly disabled (Case 3).
  static Future<void> logout({required String loginId}) async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'refreshToken');
    await _storage.delete(key: 'isLoggedIn');
    await _storage.delete(key: 'firstName');
    await _storage.delete(key: 'lastName');

    // Case 3: disable biometric on logout
    await disableBiometric(loginId: loginId);

    // If this loginId was the primary biometric account, clear that slot too
    final primary = await getPrimaryBiometricLoginId();
    if (primary == loginId) {
      await clearPrimaryBiometricAccount();
    }

    // Keep currentLoginId so login screen can pre-fill if desired
    // (you can remove this line if you prefer a blank login screen)
    // await _storage.delete(key: 'currentLoginId');
  }
}
