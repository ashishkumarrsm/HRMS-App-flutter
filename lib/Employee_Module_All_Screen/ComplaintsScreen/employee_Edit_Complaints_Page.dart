import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeEditComplaintsPage extends StatefulWidget {
  final String Description;
  final String FileName;
  final String Size;
  const EmployeeEditComplaintsPage({
    super.key,
    required this.Description,
    required this.FileName,
    required this.Size,
  });

  @override
  State<EmployeeEditComplaintsPage> createState() =>
      _EmployeeEditComplaintsPageState();
}

class _EmployeeEditComplaintsPageState
    extends State<EmployeeEditComplaintsPage> {
  String? selectedDepartment;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Align(
            alignment: AlignmentGeometry.centerStart,
            child: Text(
              "Edit Complaint",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
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
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Department*",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff27272A),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffE2E8F0)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedDepartment,
                          hint: Text(
                            "Select Department",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xff1E293B),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          focusColor: Colors.white,
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: const [
                            DropdownMenuItem(value: "HR", child: Text("HR")),
                            DropdownMenuItem(value: "IT", child: Text("IT")),
                            DropdownMenuItem(
                              value: "Finance",
                              child: Text("Finance"),
                            ),
                            DropdownMenuItem(
                              value: "Admin",
                              child: Text("Admin"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedDepartment = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Description*",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff27272A),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xffE2E8F0),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        initialValue: widget.Description,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Enter description",
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xff1F2937),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xff1E293B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upload Image*",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff27272A),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF8FAFC), // Background Color
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xffE2E8F0),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/Frame 2147235640.png",
                            width: 56,
                            height: 56,
                          ),
                          SizedBox(width: 16),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.FileName}",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff1F2937),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${widget.Size}",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff6B7280),
                                ),
                              ),
                            ],
                          ),

                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              "assets/images/trash.png",
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),


       
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xffE2E8F0))),
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffFEE2E2),
                        side: const BorderSide(color: Color(0xffFEE2E2)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffDC2626),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff644EE5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Update Complaint",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
