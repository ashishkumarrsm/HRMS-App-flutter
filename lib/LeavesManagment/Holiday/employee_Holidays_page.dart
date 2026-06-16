import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/LeavesManagment/Holiday/employee_Add_Holiday.dart';
import 'package:hrms/LeavesManagment/Holiday/employee_Holidays_Tab.dart';

class EmployeeHolidaysPage extends StatefulWidget {
  const EmployeeHolidaysPage({super.key});

  @override
  State<EmployeeHolidaysPage> createState() => _EmployeeHolidaysPageState();
}

class _EmployeeHolidaysPageState extends State<EmployeeHolidaysPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "Holidays",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeAddHoliday(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.white, size: 20),
                    label: const Text(
                      "Add Holiday",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF644EE5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(child: EmployeeHolidaysTab()),
          ],
        ),
      ),
    );
  }
}
