// import 'package:flutter/material.dart';

// class EmployeeAddHoliday extends StatefulWidget {
//   const EmployeeAddHoliday({super.key});

//   @override
//   State<EmployeeAddHoliday> createState() => _EmployeeAddHolidayState();
// }

// class _EmployeeAddHolidayState extends State<EmployeeAddHoliday> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("data"),),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:table_calendar/table_calendar.dart';

class EmployeeAddHoliday extends StatefulWidget {
  const EmployeeAddHoliday({super.key});

  @override
  State<EmployeeAddHoliday> createState() => _EmployeeAddHolidayState();
}

class _EmployeeAddHolidayState extends State<EmployeeAddHoliday> {
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> selectDate(bool isFromDate) async {
    DateTime focusedDay = DateTime.now();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(isFromDate ? "Select From Date" : "Select To Date"),
          content: SizedBox(
            width: 350,
            height: 450,
            child: TableCalendar(
              firstDay: DateTime(2026, 1, 1),
              lastDay: DateTime(2028, 12, 31),
              focusedDay: focusedDay,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              selectedDayPredicate: (day) {
                return isSameDay(isFromDate ? fromDate : toDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  if (isFromDate) {
                    fromDate = selectedDay;
                  } else {
                    toDate = selectedDay;
                  }
                });

                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: Image.asset(
          //     "assets/images/fi_8979605.png",
          //     width: 20,
          //     height: 20,
          //   ),
          // ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Add Holiday",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff27272A),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(16),
            child: Container(color: Colors.grey.shade300, height: 1),
          ),
        ),

        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      //   !main data section or column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Holiday Name",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff27272A),
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter New Holiday Name",
                              hintStyle: const TextStyle(
                                // color: Color(0xff9CA3AF),
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: Colors.white,

                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFF1F5F9),
                                ),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFF1F5F9),
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFF1F5F9),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),
                          Text(
                            "Category",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff27272A),
                            ),
                          ),

                          const SizedBox(height: 8),

                          DropdownMenu<String>(
                            // trailingIcon: const SizedBox.shrink(),
                            selectedTrailingIcon: const SizedBox.shrink(),
                            width: MediaQuery.of(context).size.width - 32,
                            hintText: "Select Catagory",

                            menuStyle: MenuStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.white,
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            inputDecorationTheme: InputDecorationTheme(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFF1F5F9),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFF1F5F9),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFF1F5F9),
                                  width: 1,
                                ),
                              ),
                            ),
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                value: "Select Catagory",
                                label: "Select Catagory",
                              ),
                              DropdownMenuEntry(
                                value: "Select Catagory 1",
                                label: "Select Catagory 1",
                              ),
                              DropdownMenuEntry(
                                value: "Select Catagory 2",
                                label: "Select Catagory 2",
                              ),
                              DropdownMenuEntry(
                                value: "Select Catagory 3",
                                label: "Select Catagory 3",
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Start Date*",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff27272A),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      InkWell(
                                        onTap: () => selectDate(true),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFE2E8F0),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                fromDate == null
                                                    ? "dd/mm/yyyy"
                                                    : "${fromDate!.day.toString().padLeft(2, '0')}/${fromDate!.month.toString().padLeft(2, '0')}/${fromDate!.year}",
                                              ),
                                              Image.asset(
                                                "assets/images/Calender.png",
                                                width: 20,
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "End Date*",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff27272A),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      InkWell(
                                        onTap: () => selectDate(false),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFE2E8F0),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                toDate == null
                                                    ? "dd/mm/yyyy"
                                                    : "${toDate!.day.toString().padLeft(2, '0')}/${toDate!.month.toString().padLeft(2, '0')}/${toDate!.year}",
                                              ),
                                              Image.asset(
                                                "assets/images/Calender.png",
                                                width: 20,
                                                height: 20,
                                              ),
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
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          //   ! Leave Reason column
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description*",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff27272A),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            minLines: 5,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "e.g. Celebration of the new year.",
                              hintStyle: GoogleFonts.inter(
                                // color: Color(0xff9CA3AF),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE2E8F0),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE2E8F0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE2E8F0),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      //   ! button section or column
                    ],
                  ),
                ),
              ),

              Container(
                height: 84,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFEDE9FE),
                            foregroundColor: Color(0xFF644EE5),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Color(0xFFEDE9FE)),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF644EE5),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Color(0xFF644EE5)),
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
