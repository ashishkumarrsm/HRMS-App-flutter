import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import 'package:flutter/services.dart';

/// Result of a biometric authentication attempt.
enum BiometricResult {
  success,
  failure, // wrong finger / face not recognized
  notAvailable, // device has no biometric hardware
  notEnrolled, // hardware exists but NO fingerprints/face stored  ← Case 1
  changed, // biometrics were CHANGED since enrollment          ← Case 2
  lockedOut, // too many failures, temporarily locked
  cancelled, // user dismissed the dialog
  error, // unknown error
}

class BiometricAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  // ─── Hardware / Enrollment check ─────────────────────────────────────────

  /// Returns true only if the device has hardware AND at least one
  /// fingerprint / face is enrolled.
  /// Use this to decide whether to show the biometric button at all (Case 1).
   
   
  Future<bool> isAvailableAndEnrolled() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final supported = await _localAuth.isDeviceSupported();
      if (!canCheck || !supported) return false;

      final enrolled = await _localAuth.getAvailableBiometrics();
      return enrolled.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // ─── Authenticate ─────────────────────────────────────────────────────────

  /// Full authenticate call that maps platform exceptions → [BiometricResult].
  Future<BiometricResult> authenticate() async {
    try {
      // Before even attempting, confirm something is enrolled (Case 1)
      final available = await isAvailableAndEnrolled();
      if (!available) return BiometricResult.notEnrolled;

      final success = await _localAuth.authenticate(
        localizedReason: 'Please verify your identity',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true, // keep prompt alive if app goes to background
          useErrorDialogs: true,
        ),
      );
      return success ? BiometricResult.success : BiometricResult.failure;
    } on PlatformException catch (e) {
      switch (e.code) {
        // No biometrics enrolled on device
        case auth_error.notEnrolled:
          return BiometricResult.notEnrolled;

        // Biometrics changed / lockout (Case 2)
        // local_auth surfaces this as notAvailable after a biometric change
        // on some Android builds, and as passcodeNotSet on iOS.
        case auth_error.notAvailable:
        case auth_error.passcodeNotSet:
          return BiometricResult.changed;

        case auth_error.lockedOut:
        case auth_error.permanentlyLockedOut:
          return BiometricResult.lockedOut;

        // case auth_error.notInteractive:
        //   return BiometricResult.cancelled;

        default:
          return BiometricResult.error;
      }
    } catch (_) {
      return BiometricResult.error;
    }
  }
}
