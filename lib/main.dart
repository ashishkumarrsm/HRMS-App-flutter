import 'package:flutter/material.dart';
import 'package:hrms/EmployeeManagment/employee_Home_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) {
        return MediaQuery(
          // This forces the text scale to always be 1.0
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: EmployeeHomeScreen(),
    );
  }
}
