import 'package:flutter/material.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Home_Card_Data.dart';
import 'package:hrms/LeavesManagment/Employee%E2%80%99s%20Leave/employee_Leave_Page.dart';
import 'package:hrms/LeavesManagment/Employee%E2%80%99s%20OverTime/employee_OverTime_Page.dart';
import 'package:hrms/LeavesManagment/Holiday/employee_Holidays_page.dart';

class LeaceHomeScreen extends StatefulWidget {
  const LeaceHomeScreen({super.key});

  @override
  State<LeaceHomeScreen> createState() => _LeaceHomeScreenState();
}

class _LeaceHomeScreenState extends State<LeaceHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text("Leave Home Screen"),
          toolbarHeight: 60,
          shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                Container(
                  height: 48,
                  padding: const EdgeInsets.all(8),

                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),

                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x1A644EE5).withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,

                    indicatorWeight: 3,

                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF644EE5),
                    ),
                    labelColor: Colors.white,
                    // unselectedLabelColor: const Color(0xFF6B7280),
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: const [
                      Tab(text: "Employee’s Leave"),
                      Tab(text: "Employee’s OT"),
                      Tab(text: "Holiday"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: TabBarView(
                    children: [
                      Center(
                        child: EmployeeLeavePage(
                          employeeId: widget.key.toString(),
                        ),
                      ),
                      Center(child: EmployeeOvertimePage()),
                      Center(child: EmployeeHolidaysPage()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
