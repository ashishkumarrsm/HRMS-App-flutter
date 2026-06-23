import 'dart:io';

/// Simple connectivity check — no external package needed.
/// Tries to look up a reliable host; returns false if offline.
/// Used by the login screen (Case 5).
class ConnectivityService {
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}