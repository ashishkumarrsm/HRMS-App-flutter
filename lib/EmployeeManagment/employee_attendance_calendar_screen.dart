import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../EmployeeManagment/Data/employee_Attendance_Data.dart';

class AttendanceCalendarScreen extends StatefulWidget {
  const AttendanceCalendarScreen({super.key});

  @override
  State<AttendanceCalendarScreen> createState() =>
      _AttendanceCalendarScreenState();
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            width: 10,
            height: 1.5,
            color: const Color(0xFFCBD5E1),
          ),
        ),
      ),
    );
  }
}

class _AttendanceCalendarScreenState extends State<AttendanceCalendarScreen> {
  DateTime currentMonth = DateTime(2025, 8);
  int selectedDay = 20;

  List<String> weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  AttendanceRecord? getRecord(int day) {
    try {
      return attendanceData.firstWhere(
        (e) =>
            e.date.year == currentMonth.year &&
            e.date.month == currentMonth.month &&
            e.date.day == day,
      );
    } catch (_) {
      return null;
    }
  }

  int getCount(AttendanceStatus status) {
    return attendanceData.where((e) => e.status == status).length;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(
      currentMonth.year,
      currentMonth.month,
    );

    final firstDay = DateTime(currentMonth.year, currentMonth.month, 1);

    final startWeekday = firstDay.weekday % 7;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// HEADER
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentMonth = DateTime(
                            currentMonth.year,
                            currentMonth.month - 1,
                          );
                        });
                      },
                      icon: const Icon(Icons.chevron_left),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "${_monthName(currentMonth.month)} ${currentMonth.year}",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentMonth = DateTime(
                            currentMonth.year,
                            currentMonth.month + 1,
                          );
                        });
                      },
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// WEEK DAYS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: weekDays
                      .map(
                        (e) => Text(
                          e,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 18),

                /// CALENDAR
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: daysInMonth + startWeekday,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index < startWeekday) {
                      return const SizedBox();
                    }

                    final day = index - startWeekday + 1;

                    final record = getRecord(day);

                    final isSelected = day == selectedDay;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = day;
                        });
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// HEADER
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_rounded,
                                        size: 24,
                                        color: Color(0xFF0F172A),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        "Work Time Details",
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 16),
                                  const Divider(color: Color(0xFFE2E8F0)),
                                  const SizedBox(height: 24),

                                  /// ATTENDANCE STATUS
                                  Row(
                                    children: [
                                      Text(
                                        "Attendance Status:",
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFDDF4E5),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Text(
                                          "Present",
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF15803D),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  /// SELECTED DATE
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Selected Date",
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF64748B),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Wednesday, August 3, 2025",
                                          style: GoogleFonts.inter(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0F172A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 28),

                                  /// TOTAL WORK TIME / OVERTIME
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total Work Time",
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF64748B),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "12:30 Hrs",
                                              style: GoogleFonts.inter(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFF0F172A),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      /// DASHED DIVIDER
                                      SizedBox(
                                        // width: 40,
                                        child: Center(child: _DashedDivider()),
                                      ),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "OverTime",
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF64748B),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "02:30 Hrs",
                                              style: GoogleFonts.inter(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFFDC2626),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xff5B4CF0)
                                  : record == null
                                  ? Colors.transparent
                                  : getStatusColor(record.status),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                "$day",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : record == null
                                      ? Colors.black
                                      : getTextColor(record.status),
                                ),
                              ),
                            ),
                          ),

                          if (record != null && record.hasFlag)
                            Positioned(
                              top: -4,
                              right: -2,
                              child: Icon(
                                Icons.flag,
                                size: 14,
                                color: getTextColor(record.status),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                /// SUMMARY
                Column(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        summaryCard(
                          "Present",
                          getCount(AttendanceStatus.present),
                          const Color(0xffECF8F0),
                          Colors.green,
                        ),

                        summaryCard(
                          "Absent",
                          getCount(AttendanceStatus.absent),
                          const Color(0xffFFF0F0),
                          Colors.red,
                        ),

                        summaryCard(
                          "On Leave",
                          getCount(AttendanceStatus.leave),
                          const Color(0xffFFFBEA),
                          Colors.amber,
                        ),

                        summaryCard(
                          "Late",
                          getCount(AttendanceStatus.late),
                          const Color(0xffF8EEFF),
                          Colors.purple,
                        ),

                        summaryCard(
                          "Early Checkout",
                          getCount(AttendanceStatus.earlyCheckout),
                          const Color(0xffFFF4E9),
                          Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget summaryCard(String title, int count, Color bgColor, Color dotColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontSize: 14)),
              const Spacer(),
              CircleAvatar(radius: 5, backgroundColor: dotColor),
            ],
          ),

          Text(
            "$count",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return months[month];
  }
}
