import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeAccountNotification extends StatefulWidget {
  const EmployeeAccountNotification({super.key});

  @override
  State<EmployeeAccountNotification> createState() =>
      _EmployeeAccountNotificationState();
}

class _EmployeeAccountNotificationState
    extends State<EmployeeAccountNotification> {
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
            "Notification",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff1F2937),
            ),
          ),
        ),
        toolbarHeight: 60,
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              // ! today
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1E293B),
                      ),
                    ),
                    SizedBox(height: 18),
                    Notification(
                      "assets/images/Frame 229.png",
                      "Weekend Travel Deals",
                      "Additional discount for all BCA debit user, lets... ",
                      "10 minutes ago ",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // ! Yesterday
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Yesterday",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1E293B),
                      ),
                    ),
                    SizedBox(height: 18),
                    Notification(
                      "assets/images/Frame 229 (1).png",
                      "Loyalty Program Launch",
                      "Join our loyalty program for exclusive deals and...  ",
                      "2 hours ago ",
                    ),
                    SizedBox(height: 18),
                    Notification(
                      "assets/images/Frame 229 (2).png",
                      "Win a Gift Card",
                      "Participate in our survey for a chance to win...  ",
                      "3 hours ago",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // ! This Week
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This Week",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1E293B),
                      ),
                    ),
                    SizedBox(height: 18),
                    Notification(
                      "assets/images/Frame 229.png",
                      "Loyalty Program Launch",
                      "Join our loyalty program for exclusive deals and...  ",
                      "2 hours ago ",
                    ),
                    SizedBox(height: 18),
                    Notification(
                      "assets/images/Frame 229 (1).png",
                      "Win a Gift Card",
                      "Participate in our survey for a chance to win...  ",
                      "3 hours ago",
                    ),
                    SizedBox(height: 18),
                    Notification(
                      "assets/images/Frame 229 (2).png",
                      "Win a Gift Card",
                      "Participate in our survey for a chance to win...  ",
                      "3 hours ago",
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

Widget Notification(String icon, String titel, String subTitel, String time) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("${icon}", width: 40, height: 40),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titel,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff171717),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  subTitel,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff171717),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  time,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff9C9C9C),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Divider(),
      ],
    ),
  );
}
