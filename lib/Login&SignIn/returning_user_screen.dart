import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/EmployeeManagment/employee_Home_Screen.dart';
import 'package:hrms/Login&SignIn/employee_Login_Page.dart';
import 'package:hrms/Service/biomatricAuthService.dart';
import 'package:hrms/Service/secure_storage_service.dart';
import 'package:hrms/Service/connectivity_service.dart';

class ReturningUserScreen extends StatefulWidget {
  const ReturningUserScreen({super.key});

  @override
  State<ReturningUserScreen> createState() => _ReturningUserScreenState();
}

class _ReturningUserScreenState extends State<ReturningUserScreen>
    with WidgetsBindingObserver {
  String _firstName = '';
  String _lastName = '';
  String _loginId = '';
  bool _isLoading = true;
  bool _isAuthenticating = false;
  bool _hasInternet = true;
  bool _isRetrying = false;

  final BiometricAuthService _bioService = BiometricAuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadUser();
    _checkInternet();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkBiometricStillValid();
      _checkInternet();
    }
  }

  // ── Loaders ───────────────────────────────────────────────────────────────

  Future<void> _loadUser() async {
    final firstName = await SecureStorageService.getFirstName();
    final lastName = await SecureStorageService.getLastName();
    final loginId = await SecureStorageService.getCurrentLoginId();
    if (mounted) {
      setState(() {
        _firstName = firstName ?? '';
        _lastName = lastName ?? '';
        _loginId = loginId ?? '';
        _isLoading = false;
      });
    }
  }

  Future<void> _checkInternet() async {
    final connected = await ConnectivityService.hasInternetConnection();
    if (mounted) setState(() => _hasInternet = connected);
  }

  Future<void> _retryConnection() async {
    setState(() => _isRetrying = true);
    await _checkInternet();
    if (mounted) setState(() => _isRetrying = false);
  }

  // ── Biometric validity ────────────────────────────────────────────────────

  Future<void> _checkBiometricStillValid() async {
    final loginId = await SecureStorageService.getCurrentLoginId();
    if (loginId == null) return;
    final enrolled = await _bioService.isAvailableAndEnrolled();
    if (!enrolled) {
      await SecureStorageService.invalidateBiometric(loginId: loginId);
      await SecureStorageService.clearPrimaryBiometricAccount();
      if (mounted) _goToLogin();
    }
  }

  // ── Authenticate ──────────────────────────────────────────────────────────

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;
    setState(() => _isAuthenticating = true);

    final loginId = await SecureStorageService.getCurrentLoginId();
    if (loginId == null) {
      _goToLogin();
      return;
    }

    // Case 1 — re-check enrollment before attempting
    final enrolled = await _bioService.isAvailableAndEnrolled();
    if (!enrolled) {
      await SecureStorageService.invalidateBiometric(loginId: loginId);
      await SecureStorageService.clearPrimaryBiometricAccount();
      if (mounted) {
        setState(() => _isAuthenticating = false);
        _showSnack(
          'No fingerprint found. Please login with your ID.',
          isError: true,
        );
        await Future.delayed(const Duration(milliseconds: 1200));
        if (mounted) _goToLogin();
      }
      return;
    }

    final result = await _bioService.authenticate();
    if (!mounted) return;
    setState(() => _isAuthenticating = false);

    switch (result) {
      case BiometricResult.success:
        final fn = await SecureStorageService.getFirstNameForLoginId(loginId);
        final ln = await SecureStorageService.getLastNameForLoginId(loginId);
        if (fn != null && ln != null) {
          await SecureStorageService.saveUserData(
            firstName: fn,
            lastName: ln,
            loginId: loginId,
          );
        }
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const EmployeeHomeScreen()),
          );
        }
        break;

      case BiometricResult.changed:
        await SecureStorageService.invalidateBiometric(loginId: loginId);
        await SecureStorageService.clearPrimaryBiometricAccount();
        _showSnack(
          'Biometric changed. Please login with ID and password.',
          isError: true,
        );
        await Future.delayed(const Duration(milliseconds: 1500));
        if (mounted) _goToLogin();
        break;

      case BiometricResult.notEnrolled:
        await SecureStorageService.invalidateBiometric(loginId: loginId);
        await SecureStorageService.clearPrimaryBiometricAccount();
        _showSnack(
          'No fingerprint on device. Please login with your ID.',
          isError: true,
        );
        await Future.delayed(const Duration(milliseconds: 1500));
        if (mounted) _goToLogin();
        break;

      case BiometricResult.lockedOut:
        _showSnack('Too many attempts. Try again in a moment.', isError: true);
        break;

      case BiometricResult.cancelled:
        break;

      default:
        _showSnack('Authentication failed. Try again.', isError: true);
    }
  }

  // Case 3 — logout + switch account
  Future<void> _switchAccount() async {
    final loginId = await SecureStorageService.getCurrentLoginId();
    if (loginId != null) {
      await SecureStorageService.logout(loginId: loginId);
    }
    if (mounted) _goToLogin();
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const EmployeeLoginScreen()),
    );
  }

  void _showSnack(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.inter(fontSize: 13)),
        backgroundColor: isError ? const Color(0xFFEF4444) : null,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  String get _initials {
    final f = _firstName.isNotEmpty ? _firstName[0].toUpperCase() : '';
    final l = _lastName.isNotEmpty ? _lastName[0].toUpperCase() : '';
    return '$f$l';
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF644EE5),
            strokeWidth: 2.5,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── No-internet banner ────────────────────────────────────────
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: _hasInternet
                  ? const SizedBox.shrink()
                  : Container(
                      color: const Color(0xFFFEF3C7),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.wifi_off_rounded,
                            size: 15,
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'No internet — you can still login with biometric',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 162, 155, 155),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: _isRetrying ? null : _retryConnection,
                            child: _isRetrying
                                ? const SizedBox(
                                    width: 13,
                                    height: 13,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFF92400E),
                                    ),
                                  )
                                : Text(
                                    'Retry',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF92400E),
                                      decoration: TextDecoration.underline,
                                      decorationColor: const Color(0xFF92400E),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
            ),

            // ── AppBar row ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _switchAccount,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    'Logout',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E293B),
                    ),
                  ),

                  Spacer(),

                  InkWell(
                    onTap: _switchAccount,
                    child: Image.asset(
                      "assets/images/Frame 863.png",
                      width: 130,
                      height: 34,
                    ),
                  ),
                ],
              ),
            ),

            // ── Main body ─────────────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    const SizedBox(height: 48),

                    // Avatar
                    Container(
                      width: 108,
                      height: 108,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF644EE5), Color(0xFF9B85F5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF644EE5).withOpacity(0.25),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _initials,
                          style: GoogleFonts.inter(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Full name
                    Text(
                      '$_firstName $_lastName'.trim(),
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 6),

                    // Login ID
                    if (_loginId.isNotEmpty)
                      Text(
                        _loginId,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF94A3B8),
                          letterSpacing: 0.5,
                        ),
                      ),

                    const SizedBox(height: 48),

                    // Biometric button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: OutlinedButton.icon(
                        onPressed: _isAuthenticating ? null : _authenticate,
                        icon: _isAuthenticating
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF644EE5),
                                ),
                              )
                            : const Icon(
                                Icons.fingerprint_rounded,
                                size: 24,
                                color: Color(0xFF644EE5),
                              ),
                        label: Text(
                          _isAuthenticating
                              ? 'Verifying...'
                              : 'Login with biometric',
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    // Offline hint under button
                    if (!_hasInternet) ...[
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            size: 13,
                            color: Color(0xFF94A3B8),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Offline mode — limited access',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const Spacer(),

                    // Switch account
                    // GestureDetector(
                    //   onTap: _switchAccount,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(bottom: 32),
                    //     child: Text(
                    //       'Use a different account',
                    //       style: GoogleFonts.inter(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w500,
                    //         color: const Color(0xFF644EE5),
                    //         decoration: TextDecoration.underline,
                    //         decorationColor: const Color(0xFF644EE5),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
