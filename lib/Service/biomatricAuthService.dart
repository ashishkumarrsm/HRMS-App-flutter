import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Biomatricauthservice {
  final LocalAuthentication localAuth = LocalAuthentication();

  Future<bool> authenticateLocally() async {
    bool isAuthenticate = false;

    try {
      isAuthenticate = await localAuth.authenticate(
        localizedReason: "localizedReason",
      );
    } on LocalAuthException catch (e) {
      if (e.code == LocalAuthExceptionCode.noBiometricHardware) {
        // Add handling of no hardware here.
      } else if (e.code == LocalAuthExceptionCode.temporaryLockout ||
          e.code == LocalAuthExceptionCode.biometricLockout) {
        // ...
      } else {
        // ...
      }
    } on PlatformException catch (e) {
      isAuthenticate = false;
      print(e);
    }

    return isAuthenticate;
  }
}

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  writeSecureData(String Key, String Value) async {
    await storage.write(key: Key, value: Value);
  }

  readSecureData(String key) async {
    await storage.read(key: key) ?? "No data found on this email ";
  }
}
