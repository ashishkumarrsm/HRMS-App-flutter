import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/LeavesManagment/Holiday/Data/employee_Holiday_data.dart';

class EmployeeHolidaysScreen extends StatefulWidget {
  const EmployeeHolidaysScreen({super.key});

  @override
  State<EmployeeHolidaysScreen> createState() => _EmployeeHolidaysScreenState();
}

class _EmployeeHolidaysScreenState extends State<EmployeeHolidaysScreen> {
  @override
  Widget build(BuildContext context) {
    // ! filter condition
    final nationalHolidays = holidayData
        .where((e) => e.category == "National Holiday")
        .toList(); 

    final festivalHolidays = holidayData
        .where((e) => e.category == "Festival Holiday")
        .toList();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: AlignmentGeometry.centerStart,
              child: Text(
                "Holidays",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff1E293B),
                ),
              ),
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
                    tabs: [
                      Tab(text: "All"),
                      Tab(text: "National Holiday"),
                      Tab(text: "Festival Holiday"),
                    ],
                  ),

                  Expanded(
                    child: TabBarView(
                      children: [
                        buildHolidayList(holidayData),
                        buildHolidayList(nationalHolidays),
                        buildHolidayList(festivalHolidays),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//!  holiday carde screen

Widget buildHolidayList(List<HolidayModel> holidays) {
  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: holidays.length,
    itemBuilder: (context, index) {
      final holiday = holidays[index];

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
            Text(
              holiday.title,
              style: GoogleFonts.inter(
                color: Color(0xFF334155),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Divider(color: Colors.grey.shade200, height: 1),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 100,
                  child: Text(
                    "Start Date",
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  ),
                ),
                Expanded(
                  child: Text(
                    holiday.startDate,
                    style: const TextStyle(
                      color: Color(0xFF334155),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 100,
                  child: Text(
                    "Description",
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  ),
                ),
                Expanded(
                  child: Text(
                    holiday.description,
                    style: const TextStyle(
                      color: Color(0xFF334155),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
