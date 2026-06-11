import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Leaves_Data.dart';
import 'package:hrms/EmployeeManagment/employss_LeaveCardWidget.dart';

class EmployeeLeaves extends StatefulWidget {
  final String employeeId;

  const EmployeeLeaves({super.key, required this.employeeId});

  @override
  State<EmployeeLeaves> createState() => _EmployeeLeavesState();
}

class _EmployeeLeavesState extends State<EmployeeLeaves>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeLeaveData = employeeLeaves
        .where((leave) => leave.employeeId == widget.employeeId)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            // ================= LEAVE CARDS =================
            for (final leave in employeeLeaveData) ...[
              LeaveCard(leave: leave),
              const SizedBox(height: 16),
            ],

            const SizedBox(height: 20),

            // ================= HEADER =================
            Text(
              "Leave History",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            // ================= TAB BAR =================
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF644EE5),
                unselectedLabelColor: const Color(0xFF64748B),
                indicatorColor: const Color(0xFF644EE5),
                tabs: const [
                  Tab(text: "Requested"),
                  Tab(text: "Approved"),
                  Tab(text: "Rejected"),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ================= TAB VIEW =================
            SizedBox(
              height: 300,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: Text("Requested Data")),
                  Center(child: Text("Approved Data")),
                  Center(child: Text("Rejected Data")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
