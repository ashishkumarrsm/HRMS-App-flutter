import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Leaves_Data.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Requeted_Approved_Rejected_Data.dart';
import 'package:hrms/EmployeeManagment/employee_Leaves_Detail.dart';
import 'package:hrms/EmployeeManagment/employss_LeaveCardWidget.dart';

class EmployeeLeavePage extends StatefulWidget {
  final String employeeId;

  const EmployeeLeavePage({super.key, required this.employeeId});

  @override
  State<EmployeeLeavePage> createState() => _EmployeeLeavePageState();
}

class _EmployeeLeavePageState extends State<EmployeeLeavePage>
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
    // ✅ TOP: ONLY SELECTED EMPLOYEE (3 CARDS FIXED)
    final employeeLeaveData = employeeLeaves
        .where((leave) => leave.employeeId == widget.employeeId)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ TOP 3 CARDS ONLY
                      for (final leave in employeeLeaveData) ...[
                        LeaveCard(leave: leave),
                        const SizedBox(height: 16),
                      ],

                      Text(
                        "Employee’s Leave",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    controller: _tabController,
                    labelColor: const Color(0xFF644EE5),
                    unselectedLabelColor: const Color(0xFF64748B),
                    indicatorColor: const Color(0xFF644EE5),
                    tabs: const [
                      Tab(text: "Requested"),
                      Tab(text: "Approved"),
                      Tab(text: "Rejected"),
                      // Tab(text: ""),
                    ],
                  ),
                ),
              ),
            ];
          },

          // ✅ TABS: ALL DATA FILTERED BY STATUS
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildLeaveList(
                leaveHistoryData.where((e) => e.status == "Requested").toList(),
              ),
              _buildLeaveList(
                leaveHistoryData.where((e) => e.status == "Approved").toList(),
              ),
              _buildLeaveList(
                leaveHistoryData.where((e) => e.status == "Rejected").toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= LIST =================
  Widget _buildLeaveList(List<LeaveHistoryRecord> leaves) {
    if (leaves.isEmpty) {
      return Center(
        child: Text(
          "No records found.",
          style: GoogleFonts.inter(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: leaves.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) => _buildHistoryCard(leaves[index]),
    );
  }

  // ================= CARD =================
  Widget _buildHistoryCard(LeaveHistoryRecord record) {
    Color pillBgColor = record.status == "Requested"
        ? const Color(0xFFFEF9C3)
        : record.status == "Approved"
        ? const Color(0xFFDCFCE7)
        : const Color(0xFFFEE2E2);
    Color pillTextColor = record.status == "Requested"
        ? const Color(0xFFCA8A04)
        : record.status == "Approved"
        ? const Color(0xFF16A34A)
        : const Color(0xFFDC2626);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      // Yahan par InkWell ka 'child' main container ko wrap kar raha hai
      child: InkWell(
        onTap: () {
          // --- NAVIGATE TO DETAIL PAGE ---
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeLeavesDetail(record: record),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  record.employeeName,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: pillBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    record.status,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: pillTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade100, height: 1),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoBlock("Leave Type", record.leaveType),
                ),
                Expanded(
                  child: _buildInfoBlock("Start Date", record.startDate),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildInfoBlock("End Date", record.endDate)),
                Expanded(
                  child: _buildInfoBlock(
                    "Requested Days",
                    record.requestedDays,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoBlock("Leave Reason", record.reason),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
}

// ================= TAB HELPER =================
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
