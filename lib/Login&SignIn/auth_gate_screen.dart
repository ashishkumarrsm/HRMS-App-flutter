import 'package:flutter/material.dart';
import 'package:hrms/Service/secure_storage_service.dart';
import 'package:hrms/Service/biomatricAuthService.dart';
import 'package:hrms/Login&SignIn/employee_Login_Page.dart';
import 'package:hrms/Login&SignIn/returning_user_screen.dart';

/// AuthGateScreen
///
/// App open hone pe sabse pehle yahi screen aati hai.
/// Yeh decide karti hai:
///   - Agar user logged in hai + biometric enabled → ReturningUserScreen (Zerodha style)
///   - Baaki sab → EmployeeLoginPage (normal login form)
///
/// Yahan koi UI nahi hai — sirf loading spinner briefly dikhta hai.
class AuthGateScreen extends StatefulWidget {
  const AuthGateScreen({super.key});

  @override
  State<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends State<AuthGateScreen> {
  @override
  void initState() {
    super.initState();
    _decide();
  }

  Future<void> _decide() async {
    final isLoggedIn = await SecureStorageService.isLoggedIn();
    final loginId = await SecureStorageService.getCurrentLoginId();

    if (!isLoggedIn || loginId == null) {
      _goTo(const EmployeeLoginScreen());
      return;
    }

    final biometricEnabled = await SecureStorageService.isBiometricEnabled(
      loginId: loginId,
    );
    final biometricInvalidated =
        await SecureStorageService.isBiometricInvalidated(loginId: loginId);

    // Check if device still has biometrics enrolled (Case 1 & 2)
    final bioService = BiometricAuthService();
    final enrolled = await bioService.isAvailableAndEnrolled();

    if (biometricEnabled && !biometricInvalidated && enrolled) {
      // Returning user with valid biometric → Zerodha style screen
      _goTo(const ReturningUserScreen());
    } else {
      // Not logged in, or biometric not set up, or invalidated → normal login
      _goTo(const EmployeeLoginScreen());
    }
  }

  void _goTo(Widget screen) {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF644EE5),
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
