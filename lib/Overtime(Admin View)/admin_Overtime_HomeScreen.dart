import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Overtime(Admin%20View)/admin_Overtime_Tab_Page.dart';

class AdminOvertimeHomescreen extends StatefulWidget {
  const AdminOvertimeHomescreen({super.key});

  @override
  State<AdminOvertimeHomescreen> createState() =>
      _AdminOvertimeHomescreenState();
}

class _AdminOvertimeHomescreenState extends State<AdminOvertimeHomescreen>
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
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Align(
          alignment: AlignmentGeometry.centerStart,
          child: Text(
            "Management OT Approvals",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),

        toolbarHeight: 60,
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),

      body: Container(
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.centerStart,
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 8,
                ),
                child: Text(
                  "Overtime List",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            Flexible(child: AdminOvertimeTabPage()),
          ],
        ),
      ),
    );
  }
}
