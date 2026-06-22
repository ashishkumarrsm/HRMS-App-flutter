import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Employee_Module_All_Screen/ComplaintsScreen/employee_Raise_Complaints.dart';
import 'package:hrms/Employee_Module_All_Screen/ComplaintsScreen/employee_Raise_Complaints_View_Detail.dart';
import '../Data/employee_Complaint_Data.dart';

class EmployeeComplaintsScreen extends StatefulWidget {
  const EmployeeComplaintsScreen({super.key});

  @override
  State<EmployeeComplaintsScreen> createState() =>
      _EmployeeComplaintsScreenState();
}

class _EmployeeComplaintsScreenState extends State<EmployeeComplaintsScreen> {
  final List<ComplaintModel> complaintList = complaintData
      .map((e) => ComplaintModel.fromJson(e))
      .toList();

  List<ComplaintModel> getFilteredData(String status) {
    return complaintList
        .where((item) => item.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  Widget buildList(String status) {
    final data = getFilteredData(status);

    if (data.isEmpty) {
      return const Center(child: Text("No Complaints Found"));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ComplaintCard(data: data[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Align(
          alignment: AlignmentGeometry.centerStart,
          child: Text(
            "Complaints",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        toolbarHeight: 60,
        shape: const Border(
          bottom: BorderSide(color: Color(0xffE2E8F0), width: 1),
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            //! heading and the Raise Complaint Button
            Row(
              children: [
                Text(
                  "Complaint List",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1E293B),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    // * ------- go to the Raise complaint page  -------
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeRaiseComplaints(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff644EE5), // Background color
                      border: Border.all(
                        color: Color(0xff644EE5), // Border color
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Raise Complaint",
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

            SizedBox(height: 16),
            // ! Tabbar
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Color(0xffE2E8F0), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelPadding: EdgeInsets.zero,

                        indicator: BoxDecoration(
                          color: const Color(0xff644EE5),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A000000),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),

                        labelColor: Colors.white,
                        unselectedLabelColor: const Color(0xFF6B7280),

                        labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),

                        unselectedLabelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),

                        tabs: const [
                          SizedBox(
                            height: 32,
                            child: Center(child: Text("Pending")),
                          ),
                          SizedBox(
                            height: 32,
                            child: Center(child: Text("Resolved")),
                          ),
                          SizedBox(
                            height: 32,
                            child: Center(child: Text("Rejected")),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          buildList("Pending"),
                          buildList("Resolved"),
                          buildList("Rejected"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComplaintCard extends StatelessWidget {
  final ComplaintModel data;

  const ComplaintCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (data.status.toLowerCase()) {
      case "resolved":
        bgColor = const Color(0xffDCFCE7);
        textColor = const Color(0xff16A34A);
        break;

      case "pending":
        bgColor = const Color(0xffFEF3C7);
        textColor = const Color(0xffD97706);
        break;

      default:
        bgColor = const Color(0xffFEE2E2);
        textColor = const Color(0xffDC2626);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeRaiseComplaintsViewDetail(
              id: data.id,
              Date: data.date,
              Department: data.department,
              Description: data.description,
              Uploaded_Image_Name: data.imageName,
              Uploaded_Image_Size: data.imageSize,
              Remarks: data.remarks,
              status: data.status,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xffE2E8F0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ///! Header
              Row(
                children: [
                  Text(
                    data.id,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      data.status,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(height: 24),
              _buildField("Date", data.date),
              SizedBox(height: 12),
              _buildField("Department", data.department),
              SizedBox(height: 12),

              /// Description
              _buildField("Description", data.description),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xff64748B),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xff334155),
            ),
          ),
        ),
      ],
    );
  }
}
