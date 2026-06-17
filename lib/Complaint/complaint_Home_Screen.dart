import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Complaint/complaint_Tab_page.dart';

class ComplaintHomeScreen extends StatefulWidget {
  const ComplaintHomeScreen({super.key});

  @override
  State<ComplaintHomeScreen> createState() => _ComplaintHomeScreenState();
}

class _ComplaintHomeScreenState extends State<ComplaintHomeScreen>
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
          child: Text("ComplaintHomeScreen"),
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
                padding: EdgeInsetsGeometry.all(16),
                child: Text(
                  "Complaint List",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            Flexible(child: ComplaintTabPage()),
          ],
        ),
      ),
    );
  }
}
