import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Home_Card_Data.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Leaves_Data.dart';

class EmployeeShiftDetails extends StatefulWidget {
  final Employee employee;
  const EmployeeShiftDetails({super.key, required this.employee});

  @override
  State<EmployeeShiftDetails> createState() => _EmployeeShiftDetailsState();
}

class _EmployeeShiftDetailsState extends State<EmployeeShiftDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // !=========card Header =======
                        Image.asset(
                          "assets/images/Icon.png",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          widget.employee.name,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF644EE5,
                            ), // background color
                            foregroundColor: Colors.white, // text color
                            elevation: 0, // shadow remove or adjust
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // rounded corners
                              side: const BorderSide(
                                color: Color(0xFF644EE5), // border color
                                width: 1, // border width
                              ),
                            ),
                          ),
                          child: Text(
                            "Edit Shift",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ! ============= Devider ===============
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Divider(),
                  ),

                  // ! ============== Shift Type ==============
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: AlignmentGeometry.centerStart,
                      child: Column(
                        children: [
                          Text(
                            "Shift Type",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF71717A),
                            ),
                          ),

                          Text(widget.employee.name),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
