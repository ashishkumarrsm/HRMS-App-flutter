import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Home_Card_Data.dart';

class EmployeeInfo extends StatefulWidget {
  final Employee employee;
  const EmployeeInfo({super.key, required this.employee});

  @override
  State<EmployeeInfo> createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Column(
          children: [
            // !==========Personal Details===========
            Align(
              alignment: AlignmentGeometry.centerStart,
              child: Text(
                "Personal Details",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 16),
            // ! ================ Info Section ==============
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          "Employee Name",
                          style: GoogleFonts.inter(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          widget.employee.name,
                          style: GoogleFonts.inter(
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          "UID",
                          style: GoogleFonts.inter(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          widget.employee.id,
                          style: GoogleFonts.inter(
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            // ! ================ Info Section ==============
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          "Gender",
                          style: GoogleFonts.inter(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          widget.employee.gender,
                          style: GoogleFonts.inter(
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          "Email Address",
                          style: GoogleFonts.inter(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          widget.employee.email,
                          style: GoogleFonts.inter(
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            // ! ================ Info Section ==============
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          "Mobile Number",
                          style: GoogleFonts.inter(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          widget.employee.mobile,
                          style: GoogleFonts.inter(
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          "Position",
                          style: GoogleFonts.inter(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          widget.employee.position,
                          style: GoogleFonts.inter(
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            // ! ================ Info Section ==============
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          "Department",
                          style: GoogleFonts.inter(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          widget.employee.department,
                          style: GoogleFonts.inter(
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          "Years of Service:",
                          style: GoogleFonts.inter(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          widget.employee.yearsOfService,
                          style: GoogleFonts.inter(
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            // ! ================ Info Section ==============
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          "Join Date",
                          style: GoogleFonts.inter(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          widget.employee.joinDate,
                          style: GoogleFonts.inter(
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
