import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Employee_Module_All_Screen/Data/employee_OverTime_Data.dart';
import 'package:hrms/Employee_Module_All_Screen/OverTime/employee_OverTime_Request_Ot_Page.dart';

class EmployeeOvertimeScreen extends StatefulWidget {
  const EmployeeOvertimeScreen({super.key});

  @override
  State<EmployeeOvertimeScreen> createState() => _EmployeeOvertimeScreenState();
}

class _EmployeeOvertimeScreenState extends State<EmployeeOvertimeScreen> {
  final List<OvertimeRequestModel> allOvertimeRequests = [
    ...pendingRequests,
    ...approvedRequests,
    ...rejectedRequests,
    ...notRequestedData,
  ];

  List<OvertimeRequestModel> getFilteredData(String status) {
    return allOvertimeRequests.where((item) {
      return item.status.trim().toLowerCase() == status.trim().toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                "OverTime Work",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff1E293B),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  print("Click on Request for ot Button ");

                  // ! Navigator to request ot page

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeOvertimeRequestOtPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff644EE5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Request for OT",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  tabs: const [
                    Tab(text: "Pending"),
                    Tab(text: "Approved"),
                    Tab(text: "Rejected"),
                  ],
                ),

                Expanded(
                  child: TabBarView(
                    children: [
                      buildOverTimeList(getFilteredData("Pending")),
                      buildOverTimeList(getFilteredData("Approved")),
                      buildOverTimeList(getFilteredData("Rejected")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// ! ========================== ====================

Widget buildOverTimeList(List<OvertimeRequestModel> overtime) {
  if (overtime.isEmpty) {
    return const Center(child: Text("No Data Found"));
  }

  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: overtime.length,
    itemBuilder: (context, index) {
      final item = overtime[index];

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * ======== card header =====
            Row(
              children: [
                Text(
                  "${item.workDate}",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: item.status.toLowerCase() == "approved"
                        ? Color(0xffDCFCE7)
                        : item.status.toLowerCase() == "rejected"
                        ? Color(0xffFEE2E2)
                        : Color(0xffFEF9C3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.status,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: item.status.toLowerCase() == "approved"
                          ? Color(0xff16A34A)
                          : item.status.toLowerCase() == "rejected"
                          ? Color(0xffDC2626)
                          : Color(0xffCA8A04),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 12),
            // *++==================== card data ============
            Column(
              children: [
                // !------ Row 1------------
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Work Date",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff64748B),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${item.workDate}",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1E293B),
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
                            "OverTime ",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff64748B),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${item.overtimeTime}",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff64748B),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${item.description}",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                item.status == "Approved"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentGeometry.centerStart,
                            child: Text(
                              "Approved OverTime ",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff64748B),
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${item.overtimeTime}",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff16A34A),
                            ),
                          ),
                        ],
                      )
                    : item.status == "Rejected"
                    ? Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xffFEF2F2), // Background color
                          border: Border.all(
                            color: const Color(0xffFECACA), // Border color
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentGeometry.centerStart,
                              child: Text(
                                "Rejection Reason",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff64748B),
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${item.description}",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1F2937),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      );
    },
  );
}
