import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeeMyLeaveRequestLeavePage extends StatefulWidget {
  const EmployeeMyLeaveRequestLeavePage({super.key});

  @override
  State<EmployeeMyLeaveRequestLeavePage> createState() =>
      _EmployeeMyLeaveRequestLeavePageState();
}

class _EmployeeMyLeaveRequestLeavePageState
    extends State<EmployeeMyLeaveRequestLeavePage> {
  DateTime? fromDate;
  DateTime? toDate;
  PlatformFile? file;
  FilePickerResult? result;

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
        resizeToAvoidBottomInset: true,
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
              "Request Leave",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          toolbarHeight: 60,
          shape: const Border(
            bottom: BorderSide(color: Color(0xffE2E8F0), width: 1),
          ),
        ),

        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                            const Text(
                              "Leave Type",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF27272A),
                              ),
                            ),

                            const SizedBox(height: 8),

                            DropdownMenu<String>(
                              // trailingIcon: const SizedBox.shrink(),
                              selectedTrailingIcon: const SizedBox.shrink(),
                              width: MediaQuery.of(context).size.width - 32,
                              hintText: "Select Leave Type",
                              menuStyle: MenuStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Color(0xFFFFFFFF),
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                              inputDecorationTheme: InputDecorationTheme(
                                filled: true,
                                fillColor: const Color(0xFFFFFFFF),
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
                                  value: "Comp Off",
                                  label: "Comp Off",
                                ),
                                DropdownMenuEntry(
                                  value: "Casual Leave",
                                  label: "Casual Leave",
                                ),
                                DropdownMenuEntry(
                                  value: "Sick Leave",
                                  label: "Sick Leave",
                                ),
                                DropdownMenuEntry(
                                  value: "Earned Leave",
                                  label: "Earned Leave",
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Leave Category",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF27272A),
                                ),
                              ),

                              const SizedBox(height: 8),

                              DropdownMenu<String>(
                                // trailingIcon: const SizedBox.shrink(),
                                selectedTrailingIcon: const SizedBox.shrink(),
                                width: MediaQuery.of(context).size.width - 32,
                                hintText: "Select Leave Type",
                                menuStyle: MenuStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Color(0xFFFFFFFF),
                                  ),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                ),
                                inputDecorationTheme: InputDecorationTheme(
                                  filled: true,
                                  fillColor: const Color(0xFFFFFFFF),
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
                                    value: "Comp Off",
                                    label: "Comp Off",
                                  ),
                                  DropdownMenuEntry(
                                    value: "Casual Leave",
                                    label: "Casual Leave",
                                  ),
                                  DropdownMenuEntry(
                                    value: "Sick Leave",
                                    label: "Sick Leave",
                                  ),
                                  DropdownMenuEntry(
                                    value: "Earned Leave",
                                    label: "Earned Leave",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "From Date",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Inter",
                                          fontSize: 14,
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
                                      const Text(
                                        "To Date",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Inter",
                                          fontSize: 14,
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
                          ],
                        ),

                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Start Duration",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF27272A),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  DropdownMenu<String>(
                                    // trailingIcon: const SizedBox.shrink(),
                                    selectedTrailingIcon:
                                        const SizedBox.shrink(),
                                    width:
                                        MediaQuery.of(context).size.width - 32,
                                    hintText: "First Half",
                                    menuStyle: MenuStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Color(0xFFFFFFFF),
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputDecorationTheme: InputDecorationTheme(
                                      filled: true,
                                      fillColor: const Color(0xFFFFFFFF),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                        value: "Comp Off",
                                        label: "Comp Off",
                                      ),
                                      DropdownMenuEntry(
                                        value: "Casual Leave",
                                        label: "Casual Leave",
                                      ),
                                      DropdownMenuEntry(
                                        value: "Sick Leave",
                                        label: "Sick Leave",
                                      ),
                                      DropdownMenuEntry(
                                        value: "Earned Leave",
                                        label: "Earned Leave",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "End Duration",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF27272A),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  DropdownMenu<String>(
                                    // trailingIcon: const SizedBox.shrink(),
                                    selectedTrailingIcon:
                                        const SizedBox.shrink(),
                                    width:
                                        MediaQuery.of(context).size.width - 32,
                                    hintText: "Second Half",
                                    menuStyle: MenuStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Color(0xFFFFFFFF),
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputDecorationTheme: InputDecorationTheme(
                                      filled: true,
                                      fillColor: const Color(0xFFFFFFFF),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                        value: "Comp Off",
                                        label: "Comp Off",
                                      ),
                                      DropdownMenuEntry(
                                        value: "Casual Leave",
                                        label: "Casual Leave",
                                      ),
                                      DropdownMenuEntry(
                                        value: "Sick Leave",
                                        label: "Sick Leave",
                                      ),
                                      DropdownMenuEntry(
                                        value: "Earned Leave",
                                        label: "Earned Leave",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          children: <Widget>[
                            //   ! Leave Reason column
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Leave Reason",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Inter",
                                  fontSize: 14,
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
                                hintText: "write your reason here",
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Attachment (optional)",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "Inter",
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFE2E8F0),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        (file == null)
                                            ? "No file Selected "
                                            : file!.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                ElevatedButton(
                                  onPressed: () async {
                                    await pickFiles(); // was: PickFiless() — wrong name + not awaited
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    backgroundColor: Color(0xFF644EE5),
                                  ),

                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/Upload image.png",
                                        width: 14,
                                        height: 14,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Upload",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //   ! button section or column
                      ],
                    ),
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
                            "Request Leave",
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

  // File Pick
  Future<void> pickFiles() async {
    // Show bottom sheet to choose source
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                // Pick from gallery using FilePicker
                result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (result == null) return;
                setState(() {
                  file = result!.files.first;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                // Pick from camera using ImagePicker
                final ImagePicker picker = ImagePicker();
                final XFile? pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile == null) return;
                setState(() async {
                  file = PlatformFile(
                    name: pickedFile.name,
                    size: await pickedFile.length(),
                    path: pickedFile.path,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
