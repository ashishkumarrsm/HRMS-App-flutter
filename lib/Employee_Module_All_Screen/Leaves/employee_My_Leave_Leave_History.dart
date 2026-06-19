import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Employee_Module_All_Screen/Data/employee_Leave_Card_Data.dart';
import 'package:hrms/Employee_Module_All_Screen/Data/employee_Leave_History_Card_data.dart';
import 'package:hrms/Employee_Module_All_Screen/Leaves/employee_My_Leave_Leave_Detail_Page.dart';
import 'package:hrms/Employee_Module_All_Screen/Leaves/employee_My_Leave_Request_Leave_Page.dart';
import '../Data/employee_Leave_History_Card_data.dart';

class EmployeeMyLeaveLeaveHistory extends StatefulWidget {
  const EmployeeMyLeaveLeaveHistory({super.key});

  @override
  State<EmployeeMyLeaveLeaveHistory> createState() =>
      _EmployeeMyLeaveLeaveHistoryState();
}

class _EmployeeMyLeaveLeaveHistoryState
    extends State<EmployeeMyLeaveLeaveHistory> {
  // ! filter
  List<LeaveHistoryModel> getFilteredData(String status) {
    if (status == "All") {
      return leaveHistoryData;
    }

    return leaveHistoryData.where((item) => item.status == status).toList();
  }
  // ! bilder

  Widget buildList(String status) {
    final data = getFilteredData(status);

    if (data.isEmpty) {
      return const Center(child: Text("No Data Found"));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return LeaveCard(data: data[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      "Leave History",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff1E293B),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff644EE5),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EmployeeMyLeaveRequestLeavePage(),
                            ),
                          );
                        },
                        child: Text(
                          "Request Leave",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: [
                  Tab(text: "All"),
                  Tab(text: "Approved"),
                  Tab(text: "Pending"),
                  Tab(text: "Rejected"),
                ],
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    buildList("All"),
                    buildList("Approved"),
                    buildList("Pending"),
                    buildList("Rejected"),
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

class LeaveCard extends StatelessWidget {
  final LeaveHistoryModel data;

  const LeaveCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // print(data.leaveType);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeMyLeaveLeaveDetailPage(
              leaveType: data.leaveType,
              leaveCategory: data.leaveCategory,
              startDate: data.startDate,
              endDate: data.endDate,
              requestedDays: data.requestedDays,
              availableLeave: data.availableLeave,
              appliedOn: data.appliedOn,
              leaveReason: data.leaveReason,
              documentName: data.documentName,
              documentSize: data.documentSize,
              approvedBy: data.approvedBy,
              status: data.status,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 0,
        color: Color(0xffFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xffE2E8F0), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // !========== header =======
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.leaveType,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: data.status == "Approved"
                          ? const Color(0xffDCFCE7)
                          : data.status == "Pending"
                          ? const Color(0xffFEF3C7)
                          : const Color(0xffFEE2E2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      data.status,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: data.status == "Approved"
                            ? const Color(0xff16A34A)
                            : data.status == "Pending"
                            ? const Color(0xffD97706)
                            : const Color(0xffDC2626),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: Text(
                              "Leave Type",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff64748B),
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Align(
                            alignment: AlignmentGeometry.centerLeft,

                            child: Text(
                              data.leaveType,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: Text(
                              "Start Date",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff64748B),
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Align(
                            alignment: AlignmentGeometry.centerLeft,

                            child: Text(
                              data.startDate,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: Text(
                              "End Date",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff64748B),
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Align(
                            alignment: AlignmentGeometry.centerLeft,

                            child: Text(
                              data.endDate,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: Text(
                              "Requested Days",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff64748B),
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Align(
                            alignment: AlignmentGeometry.centerLeft,

                            child: Text(
                              "${data.requestedDays}",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: Text(
                              "leave Reason",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff64748B),
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Align(
                            alignment: AlignmentGeometry.centerLeft,

                            child: Text(
                              data.leaveReason,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //   Expanded(
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Align(
                    //           alignment: AlignmentGeometry.centerLeft,
                    //           child: Text(
                    //             "Start Date",
                    //             style: GoogleFonts.inter(
                    //               fontSize: 12,
                    //               fontWeight: FontWeight.w400,
                    //               color: Color(0xff64748B),
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(height: 2),
                    //         Align(
                    //           alignment: AlignmentGeometry.centerLeft,

                    //           child: Text(
                    //             "${data.startDate}",
                    //             style: GoogleFonts.inter(
                    //               fontSize: 12,
                    //               fontWeight: FontWeight.w500,
                    //               color: Color(0xff334155),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
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
