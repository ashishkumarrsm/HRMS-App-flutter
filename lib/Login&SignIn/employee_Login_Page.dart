import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../Service/secure_storage_service.dart';
import '../Service/biomatricAuthService.dart';
import '../Service/connectivity_service.dart';
import '../Service/no_internet_screen.dart';
// import 'package:hrms/EmployeeManagment/employee_Home_Screen.dart';

/// EmployeeLoginScreen
///
/// Cases handled:
///   Case 1  — phone se fingerprint hata diya → biometric button hide
///   Case 2  — fingerprint change → invalidate, force re-login, re-setup
///   Case 3  — logout → biometric disabled  (done in SecureStorageService.logout)
///   Case 4  — multi-device → biometric not stored server-side, fresh setup on each device
///   Case 5  — no internet → redirect to NoInternetScreen with offline biometric
///   Case 6  — multi-account same phone → primary biometric account concept
///
/// Extra cases:
///   • App resume → re-verify biometric (handled via AppLifecycleObserver in main)
///   • Token expired → handled by API response, re-login required
///   • Biometric cancel/fail → stay on login screen, show error
class EmployeeLoginScreen extends StatefulWidget {
  const EmployeeLoginScreen({super.key});

  @override
  State<EmployeeLoginScreen> createState() => _EmployeeLoginScreenState();
}

class _EmployeeLoginScreenState extends State<EmployeeLoginScreen>
    with WidgetsBindingObserver {
  // ─── State ─────────────────────────────────────────────────────────────────
  final _loginIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordObscured = true;
  bool _isLoading = false;
  bool _showBiometricButton = false;

  // For Case 6 — which loginId has biometric set up on this device
  String? _primaryBiometricLoginId;
  String? _primaryBiometricFirstName;

  final BiometricAuthService _bioService = BiometricAuthService();

  // ─── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initScreen();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _loginIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Extra case: App comes back from background → re-check biometric validity
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initScreen();
    }
  }

  // ─── Init ──────────────────────────────────────────────────────────────────

  Future<void> _initScreen() async {
    // Case 5 — check internet first
    final hasInternet = await ConnectivityService.hasInternetConnection();
    if (!hasInternet && mounted) {
      // Check if there's a session we can continue offline
      final isLoggedIn = await SecureStorageService.isLoggedIn();
      if (isLoggedIn) {
        // Go to no-internet screen; it will handle offline biometric
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => NoInternetScreen(
              onConnected: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ),
        );
        return;
      }
      // Not logged in + no internet → stay on login but show a banner
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No internet connection. Please connect to log in.',
              style: GoogleFonts.inter(fontSize: 13),
            ),
            backgroundColor: const Color(0xFFEF4444),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }

    // Check Case 6 — is there a primary biometric account on this device?
    final primaryId = await SecureStorageService.getPrimaryBiometricLoginId();
    String? primaryFirstName;
    if (primaryId != null) {
      primaryFirstName =
          await SecureStorageService.getFirstNameForLoginId(primaryId);
      // Verify biometric is still enrolled on device (Case 1 — finger removed)
      final enrolled = await _bioService.isAvailableAndEnrolled();
      if (!enrolled) {
        // Case 1: finger removed from phone settings → disable for primary account
        await SecureStorageService.invalidateBiometric(loginId: primaryId);
        await SecureStorageService.clearPrimaryBiometricAccount();
        if (mounted) setState(() => _showBiometricButton = false);
        return;
      }

      // Case 2 — check if biometric was invalidated (changed since enrollment)
      final invalidated = await SecureStorageService.isBiometricInvalidated(
        loginId: primaryId,
      );
      if (invalidated) {
        if (mounted) {
          setState(() => _showBiometricButton = false);
          _showBiometricChangedBanner();
        }
        return;
      }
    }

    if (mounted) {
      setState(() {
        _primaryBiometricLoginId = primaryId;
        _primaryBiometricFirstName = primaryFirstName;
        _showBiometricButton =
            primaryId != null && primaryFirstName != null;
      });
    }
  }

  void _showBiometricChangedBanner() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Your biometric was changed. Please login with your ID and password.',
          style: GoogleFonts.inter(fontSize: 13),
        ),
        backgroundColor: const Color(0xFFF59E0B),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  // ─── Login API ─────────────────────────────────────────────────────────────

  Future<void> _login() async {
    final loginId = _loginIdController.text.trim();
    final password = _passwordController.text.trim();

    if (loginId.isEmpty || password.isEmpty) {
      _showSnack('Please fill all fields');
      return;
    }

    // Case 5 — check internet before making API call
    final hasInternet = await ConnectivityService.hasInternetConnection();
    if (!hasInternet) {
      _showSnack('No internet connection. Please try again.', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('https://hostelapistaging.pmu.org.in/student/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'loginId': loginId, 'password': password}),
      );

      final data = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final token = data['token'] as String;
        final refreshToken = data['refreshToken'] as String;
        final firstName = data['student']['firstName'] as String;
        final lastName = data['student']['lastName'] as String;

        await SecureStorageService.saveLoginData(
          token: token,
          refreshToken: refreshToken,
          loginId: loginId,
        );
        await SecureStorageService.saveUserData(
          firstName: firstName,
          lastName: lastName,
          loginId: loginId,
        );

        // Case 2 — if THIS account had invalidated biometric, reset it now
        final wasInvalidated = await SecureStorageService.isBiometricInvalidated(
          loginId: loginId,
        );

        final biometricAsked = await SecureStorageService.isBiometricAsked(
          loginId: loginId,
        );

        if (mounted) {
          // Show biometric setup dialog if:
          //   • Never asked before, OR
          //   • Was invalidated (Case 2) → ask again
          if (!biometricAsked || wasInvalidated) {
            _showBiometricSetupDialog(
              loginId: loginId,
              firstName: firstName,
            );
          } else {
            _goHome();
          }
        }
      } else {
        // Token expired or invalid credentials
        final message = data['message'] as String? ?? 'Login failed';
        _showSnack(message, isError: true);
      }
    } catch (e) {
      _showSnack('Something went wrong. Please try again.', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ─── Biometric Setup Dialog ────────────────────────────────────────────────

  Future<void> _showBiometricSetupDialog({
    required String loginId,
    required String firstName,
  }) async {
    // Case 6 — check if another account already has biometric on this device
    final existingPrimaryId =
        await SecureStorageService.getPrimaryBiometricLoginId();

    if (existingPrimaryId != null && existingPrimaryId != loginId) {
      // Another account owns biometric on this device → don't offer setup
      await SecureStorageService.setBiometricAsked(loginId: loginId);
      _goHome();
      return;
    }

    // Case 1 — verify device actually has biometric enrolled before showing dialog
    final enrolled = await _bioService.isAvailableAndEnrolled();
    if (!enrolled) {
      await SecureStorageService.setBiometricAsked(loginId: loginId);
      _goHome();
      return;
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Enable Biometric Login',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: const Color(0xFF1E293B),
          ),
        ),
        content: Text(
          'Hi $firstName! Would you like to use fingerprint or Face ID to log in next time?',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF64748B),
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await SecureStorageService.setBiometricAsked(loginId: loginId);
              if (ctx.mounted) Navigator.pop(ctx);
              _goHome();
            },
            child: Text(
              'Not Now',
              style: GoogleFonts.inter(color: const Color(0xFF94A3B8)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF644EE5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              final result = await _bioService.authenticate();

              if (result == BiometricResult.success) {
                await SecureStorageService.enableBiometric(loginId: loginId);
                await SecureStorageService.setBiometricAsked(loginId: loginId);
                // Case 6 — mark this loginId as the primary biometric account
                await SecureStorageService.setPrimaryBiometricAccount(loginId);

                if (ctx.mounted) Navigator.pop(ctx);
                _goHome();
              } else if (result == BiometricResult.notEnrolled) {
                // Case 1 — finger removed between login and dialog
                if (ctx.mounted) Navigator.pop(ctx);
                _showSnack(
                  'No biometric found on device. Skipping setup.',
                  isError: false,
                );
                await SecureStorageService.setBiometricAsked(loginId: loginId);
                _goHome();
              } else {
                if (ctx.mounted) Navigator.pop(ctx);
                _showSnack('Biometric setup failed. You can enable it later.');
                await SecureStorageService.setBiometricAsked(loginId: loginId);
                _goHome();
              }
            },
            child: Text(
              'Enable',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Biometric Login ───────────────────────────────────────────────────────

  Future<void> _loginWithBiometric() async {
    if (_primaryBiometricLoginId == null) return;

    final loginId = _primaryBiometricLoginId!;

    // Case 1 — re-check enrollment right before authenticating
    final enrolled = await _bioService.isAvailableAndEnrolled();
    if (!enrolled) {
      await SecureStorageService.invalidateBiometric(loginId: loginId);
      await SecureStorageService.clearPrimaryBiometricAccount();
      setState(() => _showBiometricButton = false);
      _showSnack(
        'No fingerprint found on device. Please login with your ID.',
        isError: true,
      );
      return;
    }

    final result = await _bioService.authenticate();

    switch (result) {
      case BiometricResult.success:
        // Case 4 — verify the token is still on this device
        final token = await SecureStorageService.getToken();
        if (token == null) {
          _showSnack('Session expired. Please login with your ID.', isError: true);
          setState(() => _showBiometricButton = false);
          return;
        }

        // Case 6 — biometric login always logs in the PRIMARY account
        // Load that account's user data back into storage
        final firstName = await SecureStorageService.getFirstNameForLoginId(loginId);
        final lastName = await SecureStorageService.getLastNameForLoginId(loginId);
        if (firstName != null && lastName != null) {
          await SecureStorageService.saveUserData(
            firstName: firstName,
            lastName: lastName,
            loginId: loginId,
          );
        }

        _goHome();
        break;

      case BiometricResult.changed:
        // Case 2 — biometric changed, invalidate and force password login
        await SecureStorageService.invalidateBiometric(loginId: loginId);
        await SecureStorageService.clearPrimaryBiometricAccount();
        setState(() => _showBiometricButton = false);
        _showSnack(
          'Your biometric changed. Please login with your ID and password.',
          isError: true,
        );
        break;

      case BiometricResult.notEnrolled:
        // Case 1 — all fingerprints removed from phone
        await SecureStorageService.invalidateBiometric(loginId: loginId);
        await SecureStorageService.clearPrimaryBiometricAccount();
        setState(() {
          _showBiometricButton = false;
        });
        _showSnack(
          'Fingerprint removed from device. Please login with your ID.',
          isError: true,
        );
        break;

      case BiometricResult.lockedOut:
        _showSnack(
          'Too many attempts. Try again in a moment.',
          isError: true,
        );
        break;

      case BiometricResult.cancelled:
        // User dismissed — do nothing, stay on login
        break;

      default:
        _showSnack('Biometric failed. Please login with your ID.', isError: true);
    }
  }

  // ─── Case 6 — Primary Biometric Account Dialog ────────────────────────────
  //
  // If User 2 tries to log in and User 1 has biometric set up,
  // show a dialog: "User 1 is set up with biometric. Login as User 1?"

  Future<void> _showPrimaryBiometricAccountDialog() async {
    if (_primaryBiometricFirstName == null) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Biometric Login Available',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: const Color(0xFF1E293B),
          ),
        ),
        content: Text(
          'This device has biometric login set up for $_primaryBiometricFirstName. '
          'Would you like to log in as $_primaryBiometricFirstName?',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF64748B),
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: const Color(0xFF94A3B8)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF644EE5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              _loginWithBiometric();
            },
            child: Text(
              'Login as $_primaryBiometricFirstName',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  void _goHome() {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
    // or: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => EmployeeHomeScreen()));
  }

  void _showSnack(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter(fontSize: 13)),
        backgroundColor: isError ? const Color(0xFFEF4444) : null,
      ),
    );
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // ── Header
                Text(
                  'Welcome Back',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Sign in to continue to HRMS',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 40),

                // ── User ID Field
                _label('User ID'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _loginIdController,
                  hint: 'Enter your user ID',
                  prefixIcon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 20),

                // ── Password Field
                _label('Password'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _passwordController,
                  hint: 'Enter your password',
                  obscure: _passwordObscured,
                  prefixIcon: Icons.lock_outline_rounded,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF94A3B8),
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _passwordObscured = !_passwordObscured),
                  ),
                ),
                const SizedBox(height: 32),

                // ── Login Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF644EE5),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      disabledBackgroundColor:
                          const Color(0xFF644EE5).withOpacity(0.6),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Login',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),

                // ── Biometric Button (Case 1 & 6)
                if (_showBiometricButton) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      // Case 6 — if the typed loginId is different from primary,
                      // show the "who is this for?" dialog first
                      onPressed: () {
                        final typed = _loginIdController.text.trim();
                        if (typed.isNotEmpty &&
                            typed != _primaryBiometricLoginId) {
                          _showPrimaryBiometricAccountDialog();
                        } else {
                          _loginWithBiometric();
                        }
                      },
                      icon: const Icon(
                        Icons.fingerprint_rounded,
                        color: Color(0xFF644EE5),
                        size: 22,
                      ),
                      label: Text(
                        _primaryBiometricFirstName != null
                            ? 'Login as $_primaryBiometricFirstName'
                            : 'Login with Biometric',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF644EE5),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF644EE5),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Reusable Widgets ──────────────────────────────────────────────────────

  Widget _label(String text) => Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF475569),
        ),
      );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: GoogleFonts.inter(
        fontSize: 14,
        color: const Color(0xFF1E293B),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF94A3B8),
        ),
        prefixIcon: Icon(prefixIcon, color: const Color(0xFF94A3B8), size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF644EE5), width: 2),
        ),
      ),
    );
  }
}