import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/LeavesManagment/Employee%E2%80%99s%20OverTime/employee_OverTime_Tab_Page.dart';
import 'Data/employee_OverTime_Data.dart';

class EmployeeOvertimePage extends StatefulWidget {
  const EmployeeOvertimePage({super.key});

  @override
  State<EmployeeOvertimePage> createState() => _EmployeeOvertimePageState();
}

class _EmployeeOvertimePageState extends State<EmployeeOvertimePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Null get index => null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        // padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.centerStart,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Employee’s OverTime",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // SizedBox(height: 20),
            Expanded(
              child: EmployeeOvertimeTabPage(overtimeList: overtimeData),
            ),
          ],
        ),
      ),
    );
  }
}
