import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Data/employee_OverTime_Data.dart';

class EmployeeOvertimeDetailsPage extends StatefulWidget {
  final OvertimeRecord overtimeList;

  const EmployeeOvertimeDetailsPage({super.key, required this.overtimeList});

  @override
  State<EmployeeOvertimeDetailsPage> createState() =>
      _EmployeeOvertimeDetailsPageState();
}

class _EmployeeOvertimeDetailsPageState
    extends State<EmployeeOvertimeDetailsPage>
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
    Color pillBgColor;
    Color pillTextColor;

    switch (widget.overtimeList.status) {
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

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Overtime Details",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 60,
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Employee",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF71717A),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${widget.overtimeList.employeeName} · ${widget.overtimeList.employeeId}",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: pillBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.overtimeList.status,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: pillTextColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Divider(color: Colors.grey.shade200),

            const SizedBox(height: 16),

            _buildInfoTile("Work Date", widget.overtimeList.workDate),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile(
              "Requested Overtime",
              widget.overtimeList.requestedOvertime,
              valueColor: const Color(0xFFDC2626),
            ),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile(
              "Actual Overtime",
              widget.overtimeList.actualOvertime,
              valueColor: const Color(0xFF16A34A),
            ),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile("Punch In", widget.overtimeList.punchIn),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile("Punch Out", widget.overtimeList.punchOut),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile(
              "Total Work Time",
              widget.overtimeList.totalWorkTime,
            ),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile("Description", widget.overtimeList.description),
            Divider(color: Colors.grey.shade200),

            if (widget.overtimeList.status == "Rejected") ...[
              const SizedBox(height: 20),

              _buildInfoTile(
                "Rejected By",
                "John Manager",
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: Color(0xFFFEF2F2),
                    border: Border.all(
                      color: const Color(0xFFFECACA),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(
                          "Rejection Reason",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ),

                      SizedBox(height: 8),
                      Text(
                        "The overtime hours submitted do not align with project timelines and budget constraints. Please prioritize tasks within regular working hours.",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar:
          widget.overtimeList.status.trim().toLowerCase() == "requested"
          ? SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: const Color(0xFFFEE2E2),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Reject",
                          style: GoogleFonts.inter(
                            color: const Color(0xFFDC2626),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: const Color(0xFF644EE5),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Approve",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildInfoTile(
    String title,
    String value, {
    Color valueColor = Colors.black,
    Widget? child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF71717A),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: valueColor,
            ),
          ),
          if (child != null) ...[const SizedBox(height: 8), child],
        ],
      ),
    );
  }
}
