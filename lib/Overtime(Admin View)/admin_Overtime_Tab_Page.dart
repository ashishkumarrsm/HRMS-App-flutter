// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Overtime(Admin%20View)/admin_Overtime_Details.dart';
// import 'package:image_picker/image_picker.dart';

import 'Data/admin_Overtime_Data.dart';

class AdminOvertimeTabPage extends StatefulWidget {
  const AdminOvertimeTabPage({super.key});

  @override
  State<AdminOvertimeTabPage> createState() => _AdminOvertimeTabPageState();
}

class _AdminOvertimeTabPageState extends State<AdminOvertimeTabPage>
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                      color: Colors.black.withOpacity(0.05),
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
                    Tab(text: "Pending"),
                    Tab(text: "Approved"),
                    Tab(text: "Rejected"),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Center(child: OvertimeListView(statusFilter: "Pending")),
                    Center(child: OvertimeListView(statusFilter: "Approved")),
                    Center(child: OvertimeListView(statusFilter: "Rejected")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ! Search and card holder

class OvertimeListView extends StatelessWidget {
  final String statusFilter;

  const OvertimeListView({super.key, required this.statusFilter});

  @override
  Widget build(BuildContext context) {
    final filteredList = dummyOvertimeList
        .where((item) => item.status == statusFilter)
        .toList();

    return Column(
      children: [
        // 🔍 SEARCH
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search by name or ID...",

              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  "assets/images/search-status.png",
                  width: 18,
                  height: 18,
                  fit: BoxFit.contain,
                ),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(
                  color: Color(0xFF64748B),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),

        // 📋 LIST
        Expanded(
          child: filteredList.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/Checklist Illustration Woman 1.png",
                        ),
                        Text(
                          "No Complaints Found",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "You haven't raised any complaints yet. Your submitted issues will appear here once created.",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final complaint = filteredList[index];

                    return EmployeeCard(
                      overtime: complaint,
                      // name: complaint.employeeName,
                      // status: complaint.status,
                      // gender: complaint.gender,
                      // complaintId: complaint.complaintId,
                      // complaintDate: complaint.complaintDate,
                      // position: complaint.position,
                      // department: complaint.department,
                      // Discription: complaint.description,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ! card bp
class EmployeeCard extends StatefulWidget {
  final OvertimeRecord overtime;

  const EmployeeCard({super.key, required this.overtime});

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFFE2E8F0), // border color
          width: 1, // border thickness
        ),
      ),

      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

      child: InkWell(
        onTap: () {
          print(widget.overtime.employeeId);
          setState(() {
            isSelected = !isSelected;
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AdminOvertimeDetails(overTime: widget.overtime),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              // ! Header Section of a card
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/Doctor.png",
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${widget.overtime.employeeName}",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "· ${widget.overtime.gender}",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: widget.overtime.status == "Pending"
                            ? Color(0xFFFEF9C3)
                            : widget.overtime.status == "Approved"
                            ? Color(0xFFDCFCE7)
                            : widget.overtime.status == "Rejected"
                            ? Color(0xFFFEE2E2)
                            : Colors.grey.withOpacity(0.15),

                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: widget.overtime.status == "Pending"
                              ? Color(0xFFFEF9C3)
                              : widget.overtime.status == "Approved"
                              ? Color(0xFFDCFCE7)
                              : widget.overtime.status == "Rejected"
                              ? Color(0xFFFEE2E2)
                              : Colors.grey,
                        ),
                      ),
                      child: Text(
                        widget.overtime.status,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: widget.overtime.status == "Pending"
                              ? Color(0xFFCA8A04)
                              : widget.overtime.status == "Approved"
                              ? Color(0xFF16A34A)
                              : widget.overtime.status == "Rejected"
                              ? Color(0xFFDC2626)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: Divider(height: 5),
              ),
              // ! data Diaplay
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [
                    // ? Row 1
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Overtime Requested Date",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                "${widget.overtime.workDate}",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Department",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                "${widget.overtime.department}",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // ? Row 2
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Actual Work Hrs",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                "${widget.overtime.actualWorkHrs}",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Overtime Request",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                "${widget.overtime.overtimeRequest}",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // ? Row 3
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Actual Overtime",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                "${widget.overtime.actualOvertime}",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                " . ${widget.overtime.status}",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: widget.overtime.status == "Pending"
                                      ? const Color(0xFFCA8A04)
                                      : widget.overtime.status == "Approved"
                                      ? const Color(0xFF16A34A)
                                      : widget.overtime.status == "Rejected"
                                      ? const Color(0xFFDC2626)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // ? Row 4
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Discription",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                "${widget.overtime.description}",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "Department",
                        //         style: GoogleFonts.inter(
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w400,
                        //           color: Color(0xFF64748B),
                        //         ),
                        //       ),
                        //       Text(
                        //         "${widget.department}",
                        //         style: GoogleFonts.inter(
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
