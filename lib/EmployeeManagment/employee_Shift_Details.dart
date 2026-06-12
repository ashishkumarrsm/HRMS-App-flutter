import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Home_Card_Data.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Shift_Card_Data.dart';

class EmployeeShiftDetails extends StatefulWidget {
  final Employee employee;
  const EmployeeShiftDetails({super.key, required this.employee});

  @override
  State<EmployeeShiftDetails> createState() => _EmployeeShiftDetailsState();
}

class _EmployeeShiftDetailsState extends State<EmployeeShiftDetails> {
  // This helper function finds the shift data for the current employee
  // using the dummy data list we created.
  EmployeeShift _getEmployeeShift() {
    return employeeShifts.firstWhere(
      (shift) => shift.employeeId == widget.employee.id,
      // Fallback in case an employee doesn't have a shift assigned
      orElse: () => EmployeeShift(
        employeeId: widget.employee.id,
        shiftType: "Not Assigned",
        startTime: "--:--",
        endTime: "--:--",
        department: "N/A",
        date: "N/A",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the specific shift data for this employee
    final shiftData = _getEmployeeShift();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
        child: Column(
          children: [
            Card(
              elevation: 0,
              color: const Color(0xFFFAFAFA), // Light grey background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200), // Subtle border
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // !========= Card Header =========
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 12,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/Icon.png",
                          width: 20,
                          height: 20,
                        ),
                        // Replaced asset with standard icon for quick testing
                        const SizedBox(width: 12),
                        Text(
                          "${widget.employee.name}'s Shift",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF18181B),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF644EE5),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Edit Shift",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ! ============= Divider ===============
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(color: Colors.grey.shade200, height: 1),
                  ),

                  // ! ============== Shift Content ==============
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shift Type
                        _buildLabel("Shift Type"),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFF3EBFF,
                            ), // Light purple background
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            shiftData.shiftType,
                            style: GoogleFonts.inter(
                              color: const Color(
                                0xFF644EE5,
                              ), // Dark purple text
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Time
                        _buildLabel("Time"),
                        const SizedBox(height: 8),
                        Text(
                          "${shiftData.startTime} - ${shiftData.endTime}",
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Department
                        _buildLabel("Department"),
                        const SizedBox(height: 8),
                        Text(
                          shiftData.department,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Date
                        _buildLabel("Date"),
                        const SizedBox(height: 8),
                        Text(
                          shiftData.date,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for the grey labels (Shift Type, Time, Department, Date)
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF71717A), // Grey text color
      ),
    );
  }
}
