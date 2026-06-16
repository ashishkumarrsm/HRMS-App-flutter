import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShiftEdit extends StatefulWidget {
  final Map<String, String> shiftData;
  const ShiftEdit({super.key, required this.shiftData});

  @override
  State<ShiftEdit> createState() => _ShiftEditState();
}

class _ShiftEditState extends State<ShiftEdit> {
  String selectedValue = "Morning Shift";
  String selectDepartment = "Cardiology";

  TimeOfDay shiftStart = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay shiftEnd = const TimeOfDay(hour: 18, minute: 0);

  Future<void> _selectTime(bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? shiftStart : shiftEnd,

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: const TimePickerThemeData(
              backgroundColor: Color(0xFFFFFFFF), // 👈 BACKGROUND COLOR
              hourMinuteTextColor: Color(0xFF1E293B),
              dialHandColor: Color(0xFF644EE5),
              dialBackgroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          shiftStart = picked;
        } else {
          shiftEnd = picked;
        }
      });
    }
  }

  String formatTime(BuildContext context, TimeOfDay time) {
    return time.format(context);
  }

  Widget buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),

      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          dropdownColor: const Color(0xFFFFFFFF),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          style: const TextStyle(fontSize: 16, color: Color(0xFF1E293B)),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget buildTimeField({
    required String title,
    required TimeOfDay time,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Material(
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),

              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(context, time),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const Icon(Icons.access_time_outlined),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: const Text("Edit Shift"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xFFE2E8F0)),
        ),
      ),

      body: Column(
        children: [
          // 🔥 Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Employee",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: widget.shiftData["name"],
                    readOnly: true,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF1E293B),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF1F5F9),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Shift Type",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  buildDropdown(
                    value: selectedValue,
                    items: const [
                      "Morning Shift",
                      "Evening Shift",
                      "Night Shift",
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => selectedValue = value);
                    },
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Department",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  buildDropdown(
                    value: selectDepartment,
                    items: const [
                      "Cardiology",
                      "Neurology",
                      "Orthopedics",
                      "Radiology",
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => selectDepartment = value);
                    },
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      buildTimeField(
                        title: "Shift Start",
                        time: shiftStart,
                        onTap: () => _selectTime(true),
                      ),
                      const SizedBox(width: 16),
                      buildTimeField(
                        title: "Shift End",
                        time: shiftEnd,
                        onTap: () => _selectTime(false),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // 🔥 Bottom Buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              children: [
                // ❌ Cancel
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFFEDE9FE),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide.none,
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Color(0xFF644EE5)),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // ✅ Submit
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // submit logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF644EE5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
