import 'package:flutter/material.dart';
import 'package:hrms/Login&SignIn/employee_Login_Page.dart';

// import 'package:hrms/EmployeeManagment/employee_Home_Screen.dart';

/// main.dart
///
/// Entry point. Routes are named so screens can navigate without
/// direct imports (avoids circular deps).
///
/// Named routes:
///   /login  → EmployeeLoginScreen
///   /home   → EmployeeHomeScreen  (replace with your actual screen)
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HRMSApp());
}

class HRMSApp extends StatelessWidget {
  const HRMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PMCH HRMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF644EE5)),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const EmployeeLoginScreen(),
        // '/home': (_) => EmployeeHomeScreen(),  ← uncomment when ready
      },
    );
  }
}
