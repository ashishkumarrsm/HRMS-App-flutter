import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Home_Card_Data.dart';
import 'package:hrms/EmployeeManagment/employee_Info.dart';
import 'package:hrms/EmployeeManagment/employee_Leaves.dart';
import 'package:hrms/EmployeeManagment/employee_Shift_Details.dart';
import 'package:hrms/EmployeeManagment/employee_attendance_calendar_screen.dart';

class EmployeeEmployeeDetailsScreen extends StatefulWidget {
  final Employee employee;

  const EmployeeEmployeeDetailsScreen({super.key, required this.employee});

  @override
  State<EmployeeEmployeeDetailsScreen> createState() =>
      _EmployeeEmployeeDetailsScreenState();
}

class _EmployeeEmployeeDetailsScreenState
    extends State<EmployeeEmployeeDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Avatar Initials
  String getInitials(String name) {
    List<String> names = name.trim().split(' ');

    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }

    return names[0][0].toUpperCase();
  }

  Widget infoTile(String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        title: Align(
          alignment: AlignmentGeometry.centerStart,
          child: Text(
            "Employee Details",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
      ),

      body: Column(
        children: [
          // ================= Header =================
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xFFFBCFE8),
                  child: Text(
                    getInitials(widget.employee.name),
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.employee.name,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Image.asset(
                            "assets/images/Calll.png",
                            width: 18,
                            height: 18,
                          ),

                          const SizedBox(width: 8),

                          Text(
                            widget.employee.mobile,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: widget.employee.isActive
                        ? const Color(0xFFDCFCE7)
                        : const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    widget.employee.isActive ? "Active" : "Inactive",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: widget.employee.isActive
                          ? const Color(0xFF16A34A)
                          : const Color(0xFFDC2626),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // const Divider(height: 1, color: Color(0xFFE5E7EB)),

          // ================= TabBar =================
          TabBar(
            controller: _tabController,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            indicatorColor: const Color(0xFF644EE5),
            indicatorWeight: 3,
            tabAlignment: TabAlignment.center,
            isScrollable: false,
            labelColor: const Color(0xFF644EE5),
            // unselectedLabelColor: const Color(0xFF64748B),
            labelStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: "Employee Info"),
              Tab(text: "Attendance"),
              Tab(text: "Leaves"),
              Tab(text: "Shift"),
            ],
          ),

          const Divider(height: 1, color: Color(0xFFE5E7EB)),

          // ================= Tab Content =================
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // ! =============== Employee Info ==============
                EmployeeInfo(
                  employee: Employee(
                    name: widget.employee.name,
                    id: widget.employee.id,
                    gender: widget.employee.gender,
                    role: widget.employee.role,
                    isActive: widget.employee.isActive,
                    email: widget.employee.email,
                    mobile: widget.employee.mobile,
                    position: widget.employee.position,
                    department: widget.employee.department,
                    yearsOfService: widget.employee.yearsOfService,
                    joinDate: widget.employee.joinDate,
                  ),
                ),

                //!=========== Attendance========
                // AttendanceCalendarScreen(),
                EmployeeAttendanceCalendarScreen(),

                //! ============== Leaves===========
                EmployeeLeaves(employeeId: widget.employee.id),

                // !========= Shift =============
                EmployeeShiftDetails(
                  employee: Employee(
                    name: widget.employee.name,
                    id: widget.employee.id,
                    gender: widget.employee.gender,
                    role: widget.employee.role,
                    isActive: widget.employee.isActive,
                    email: widget.employee.email,
                    mobile: widget.employee.mobile,
                    position: widget.employee.position,
                    department: widget.employee.department,
                    yearsOfService: widget.employee.yearsOfService,
                    joinDate: widget.employee.joinDate,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
