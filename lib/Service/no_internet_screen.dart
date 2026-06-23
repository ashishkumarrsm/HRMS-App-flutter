import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './biomatricAuthService.dart';
import 'secure_storage_service.dart';
import 'connectivity_service.dart';

/// NoInternetScreen
///
/// Shown when the user opens the app and has no internet connection (Case 5).
///
/// Logic:
///   - If biometric is enabled for the last logged-in account → show biometric
///     login option so the user can still access the app offline.
///   - "Retry" button re-checks connectivity.
///   - If connectivity is restored → pop and let the normal flow continue.
class NoInternetScreen extends StatefulWidget {
  final VoidCallback onConnected;

  const NoInternetScreen({super.key, required this.onConnected});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool _biometricAvailable = false;
  bool _biometricEnabled = false;
  bool _checking = false;
  String? _loginId;
  String? _firstName;
  final BiometricAuthService _bioService = BiometricAuthService();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final loginId = await SecureStorageService.getCurrentLoginId();
    if (loginId == null) return;

    final biometricEnabled =
        await SecureStorageService.isBiometricEnabled(loginId: loginId);
    final biometricAvailable = await _bioService.isAvailableAndEnrolled();
    final firstName = await SecureStorageService.getFirstName();

    if (mounted) {
      setState(() {
        _loginId = loginId;
        _biometricEnabled = biometricEnabled;
        _biometricAvailable = biometricAvailable;
        _firstName = firstName;
      });
    }
  }

  Future<void> _retryConnection() async {
    setState(() => _checking = true);
    final connected = await ConnectivityService.hasInternetConnection();
    setState(() => _checking = false);

    if (connected) {
      widget.onConnected();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Still no internet. Please check your connection.',
              style: GoogleFonts.inter(fontSize: 13),
            ),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  Future<void> _loginWithBiometric() async {
    if (_loginId == null) return;

    final result = await _bioService.authenticate();

    if (result == BiometricResult.success) {
      final token = await SecureStorageService.getToken();
      if (token != null && mounted) {
        // Token exists from previous session — allow offline access
        // Navigate to home; the home screen will handle token refresh when online
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else if (result == BiometricResult.changed) {
      await SecureStorageService.invalidateBiometric(loginId: _loginId!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Biometric changed. Please connect to internet and login again.',
              style: GoogleFonts.inter(fontSize: 13),
            ),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
        setState(() {
          _biometricEnabled = false;
        });
      }
    } else if (result == BiometricResult.notEnrolled) {
      await SecureStorageService.invalidateBiometric(loginId: _loginId!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No fingerprint found on device. Connect to internet to login.',
              style: GoogleFonts.inter(fontSize: 13),
            ),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
        setState(() {
          _biometricEnabled = false;
          _biometricAvailable = false;
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Biometric failed. Try again.',
              style: GoogleFonts.inter(fontSize: 13),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.wifi_off_rounded,
                  size: 44,
                  color: Color(0xFF644EE5),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'No Internet Connection',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Please check your Wi-Fi or mobile data and try again.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF64748B),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 36),

              // Retry button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _checking ? null : _retryConnection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF644EE5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _checking
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Retry Connection',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              // Case 5 — biometric offline login
              if (_biometricEnabled && _biometricAvailable) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: _loginWithBiometric,
                    icon: const Icon(
                      Icons.fingerprint_rounded,
                      color: Color(0xFF644EE5),
                    ),
                    label: Text(
                      _firstName != null
                          ? 'Continue as $_firstName'
                          : 'Login with Biometric',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF644EE5),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF644EE5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You can access the app offline using biometric.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF94A3B8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}