import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Employee_Module_All_Screen/Holidays/employee_Holidays_Screen.dart';
import 'package:hrms/Employee_Module_All_Screen/Leaves/employee_My_Leave_Card.dart';
import 'package:hrms/Employee_Module_All_Screen/Leaves/employee_My_Leave_Leave_History.dart';
import 'package:hrms/Employee_Module_All_Screen/OverTime/employee_OverTime_Screen.dart';
import './Data/employee_Leave_Card_Data.dart';

class LeaveManagementHomeScreen extends StatefulWidget {
  const LeaveManagementHomeScreen({super.key});

  @override
  State<LeaveManagementHomeScreen> createState() =>
      _LeaveManagementHomeScreenState();
}

class _LeaveManagementHomeScreenState extends State<LeaveManagementHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Align(
          alignment: AlignmentGeometry.centerStart,
          child: Text(
            "Leave Management",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        toolbarHeight: 60,
        shape: const Border(
          bottom: BorderSide(color: Color(0xffE2E8F0), width: 1),
        ),
      ),

      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF6B7280),
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6A5AE0), Color(0xFF5B4AE6)],
                  ),
                ),
                tabs: const [
                  Tab(text: "My Leave"),
                  Tab(text: "OverTime"),
                  Tab(text: "Holidays"),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  //* ---------------- My Leave Tab ----------------
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // History ko guaranteed height milegi, cards ki height
                      // se independent — isliye kabhi overflow nahi karega.
                      // 0.6 = available tab height ka 60%. Chahe to ye value
                      // apni pasand se 0.5 - 0.7 ke beech adjust kar sakte ho.
                      final double historyHeight = constraints.maxHeight * 1;

                      return CustomScrollView(
                        slivers: [
                          // Leave balance cards
                          SliverToBoxAdapter(
                            child: Column(
                              children: leaveBalanceData.map((data) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: EmployeeMyLeaveCard(leave: data),
                                );
                              }).toList(),
                            ),
                          ),

                          // Leave History — fixed, guaranteed height
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: historyHeight,
                              child: const EmployeeMyLeaveLeaveHistory(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // *------------------- Overtime tab---------------
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double historyHeight = constraints.maxHeight * 1;
                      return CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: historyHeight,
                              child: EmployeeOvertimeScreen(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // *------------------- Holiday tab---------------
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double historyHeight = constraints.maxHeight * 1;
                      return CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: historyHeight,
                              child: EmployeeHolidaysScreen(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
