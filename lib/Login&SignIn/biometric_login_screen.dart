import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/EmployeeManagment/employee_Home_Screen.dart';
import 'package:hrms/Login&SignIn/employee_Login_Page.dart';
import '../Service/biomatricAuthService.dart';
import 'package:hrms/Service/secure_storage_service.dart';

class BiometricLoginScreen extends StatefulWidget {
  const BiometricLoginScreen({super.key});

  @override
  State<BiometricLoginScreen> createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen> {
  String firstName = '';
  String lastName = '';
  bool isLoading = true;
  bool isAuthenticating = false;

  final BiometricAuthService _bioService = BiometricAuthService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final fName = await SecureStorageService.getFirstName();
    final lName = await SecureStorageService.getLastName();
    if (mounted) {
      setState(() {
        firstName = fName ?? '';
        lastName = lName ?? '';
        isLoading = false;
      });
    }
  }

  Future<void> _authenticateWithBiometric() async {
    setState(() => isAuthenticating = true);

    final result = await _bioService.authenticate();

    if (!mounted) return;

    switch (result) {
      case BiometricResult.success:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const EmployeeHomeScreen()),
        );
        break;

      case BiometricResult.changed:
      case BiometricResult.notEnrolled:
        // Biometric changed or removed — invalidate and go to login
        final loginId = await SecureStorageService.getCurrentLoginId();
        if (loginId != null) {
          await SecureStorageService.invalidateBiometric(loginId: loginId);
          await SecureStorageService.clearPrimaryBiometricAccount();
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result == BiometricResult.changed
                  ? 'Biometric changed. Please login with your ID and password.'
                  : 'No fingerprint found on device. Please login with your ID.',
              style: GoogleFonts.inter(fontSize: 13),
            ),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        if (!mounted) return;
        _goToLogin();
        break;

      case BiometricResult.lockedOut:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Too many attempts. Please try again in a moment.',
              style: GoogleFonts.inter(fontSize: 13),
            ),
            backgroundColor: const Color(0xFFF59E0B),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        break;

      case BiometricResult.cancelled:
        // User dismissed — do nothing, stay on screen
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Biometric authentication failed. Try again.',
              style: GoogleFonts.inter(fontSize: 13),
            ),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
    }

    if (mounted) setState(() => isAuthenticating = false);
  }

  Future<void> _logout() async {
    final loginId = await SecureStorageService.getCurrentLoginId();
    if (loginId != null) {
      await SecureStorageService.logout(loginId: loginId);
    }
    if (!mounted) return;
    _goToLogin();
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const EmployeeLoginScreen()),
    );
  }

  String get initials {
    final f = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final l = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$f$l';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 60),

                      // App branding
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'PMCH HRMS',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),

                      const SizedBox(height: 60),

                      // Avatar circle with initials
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF644EE5), Color(0xFF8B6FF0)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF644EE5).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            initials,
                            style: GoogleFonts.inter(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        '$firstName $lastName',
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Verify your identity to continue',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),

                      const SizedBox(height: 56),

                      // Fingerprint tap button
                      GestureDetector(
                        onTap: isAuthenticating
                            ? null
                            : _authenticateWithBiometric,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isAuthenticating
                                ? const Color(0xFF644EE5).withOpacity(0.1)
                                : Colors.white,
                            border: Border.all(
                              color: const Color(0xFF644EE5),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF644EE5,
                                ).withOpacity(0.15),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: isAuthenticating
                              ? const Center(
                                  child: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Color(0xFF644EE5),
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.fingerprint,
                                  size: 48,
                                  color: Color(0xFF644EE5),
                                ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        isAuthenticating
                            ? 'Verifying...'
                            : 'Tap to use Biometric',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const Spacer(),

                      TextButton(
                        onPressed: _logout,
                        child: Text(
                          'Use a different account',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFF644EE5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
