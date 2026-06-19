import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/LeavesManagment/Employee%E2%80%99s%20OverTime/employee_Overtime_Details_Page.dart';
import 'package:hrms/LeavesManagment/Employee’s OverTime/Data/employee_OverTime_Data.dart';

class EmployeeOvertimeTabPage extends StatefulWidget {
  final List<OvertimeRecord> overtimeList;

  const EmployeeOvertimeTabPage({super.key, required this.overtimeList});

  @override
  State<EmployeeOvertimeTabPage> createState() =>
      _EmployeeOvertimeTabPageState();
}

class _EmployeeOvertimeTabPageState extends State<EmployeeOvertimeTabPage>
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

  Widget buildList(String status) {
    final filteredList = widget.overtimeList
        .where((item) => item.status == status)
        .toList();

    if (filteredList.isEmpty) {
      return const Center(child: Text("No Records Found"));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filteredList.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final overtime = filteredList[index];

        Color pillBgColor;
        Color pillTextColor;

        switch (overtime.status) {
          case "Approved":
            pillBgColor = const Color(0xFFDCFCE7);
            pillTextColor = const Color(0xFF16A34A);
            break;

          case "Rejected":
            pillBgColor = const Color(0xFFFEE2E2);
            pillTextColor = const Color(0xFFDC2626);
            break;

          default:
            pillBgColor = const Color(0xFFFEF9C3);
            pillTextColor = const Color(0xFFCA8A04);
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EmployeeOvertimeDetailsPage(overtimeList: overtime),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        overtime.employeeName,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: pillBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        overtime.status,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: pillTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Divider(color: Colors.grey.shade200),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildInfoBlock("Work Date", overtime.workDate),
                    ),
                    Expanded(
                      child: _buildInfoBlock(
                        "OverTime ",
                        overtime.requestedOvertime,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _buildInfoBlock("Description", overtime.description),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoBlock(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFFA1A1AA),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            labelColor: const Color(0xFF644EE5),
            unselectedLabelColor: const Color(0xFF64748B),
            indicatorColor: const Color(0xFF644EE5),
            indicatorWeight: 3,
            labelStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: "Requested"),
              Tab(text: "Approved"),
              Tab(text: "Rejected"),
            ],
          ),
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              buildList("Requested"),
              buildList("Approved"),
              buildList("Rejected"),
            ],
          ),
        ),
      ],
    );
  }
}
