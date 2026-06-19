import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeeOvertimeRequestOtPage extends StatefulWidget {
  const EmployeeOvertimeRequestOtPage({super.key});

  @override
  State<EmployeeOvertimeRequestOtPage> createState() =>
      _EmployeeOvertimeRequestOtPageState();
}

class _EmployeeOvertimeRequestOtPageState
    extends State<EmployeeOvertimeRequestOtPage> {
  DateTime? selectedDate;
  int otHour = 0;
  int otMinute = 0;

  final TextEditingController descriptionController = TextEditingController();

  static const Color borderColor = Color(0xffE2E8F0);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);
  static const Color placeholderGrey = Color(0xFF94A3B8);
  static const Color purple = Color(0xFF4F46E5);
  static const Color purpleLight = Color(0xffEDE9FE);

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  // ---------- Date picker (kept your TableCalendar-in-dialog approach) ----------
  Future<void> _selectDate() async {
    final DateTime focusedDay = selectedDate ?? DateTime.now();

    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Select Date",
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          content: SizedBox(
            width: 350,
            height: 400,
            child: TableCalendar(
              firstDay: DateTime(2026, 1, 1),
              lastDay: DateTime(2028, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) => isSameDay(selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                Navigator.pop(context, selectedDay);
              },
              daysOfWeekHeight: 20,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                leftChevronPadding: EdgeInsets.only(right: 12),
                rightChevronPadding: EdgeInsets.only(left: 12),
              ),
            ),
          ),
        );
      },
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  // ---------- Hour / Minute steppers ----------
  void _incrementHour() => setState(() {
    if (otHour < 23) otHour++;
  });

  void _decrementHour() => setState(() {
    if (otHour > 0) otHour--;
  });

  void _incrementMinute() => setState(() {
    if (otMinute < 59) otMinute++;
  });

  void _decrementMinute() => setState(() {
    if (otMinute > 0) otMinute--;
  });

  // ---------- Actions ----------
  void _onCancel() {
    Navigator.pop(context);
  }

  void _onSubmit() {
    if (selectedDate == null) {
      _showSnack("Please select a date");
      return;
    }
    if (otHour == 0 && otMinute == 0) {
      _showSnack("Please add overtime hours or minutes");
      return;
    }
    if (descriptionController.text.trim().isEmpty) {
      _showSnack("Please write a description");
      return;
    }

    final payload = {
      "date":
          "${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}",
      "hour": otHour,
      "minute": otMinute,
      "description": descriptionController.text.trim(),
    };

    // TODO: replace this with your real API call, e.g.
    // await OvertimeService.submitRequest(payload);
    debugPrint("Submitting OT request: $payload");

    _showSnack("Overtime request submitted");
    Navigator.pop(context);
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Request OT",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
          ),
        ),
        toolbarHeight: 60,
        shape: const Border(bottom: BorderSide(color: borderColor, width: 1)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Date"),
            const SizedBox(height: 8),
            _buildDateField(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStepperColumn(
                    label: "Add Hour",
                    prefix: "Hr",
                    value: otHour,
                    onIncrement: _incrementHour,
                    onDecrement: _decrementHour,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStepperColumn(
                    label: "Add Minute",
                    prefix: "Min",
                    value: otMinute,
                    onIncrement: _incrementMinute,
                    onDecrement: _decrementMinute,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildLabel("Description"),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              style: GoogleFonts.inter(fontSize: 14, color: textDark),
              decoration: InputDecoration(
                hintText: "write about your overtime work",
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: placeholderGrey,
                ),
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: borderColor),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: borderColor, width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: _onCancel,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: purpleLight,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: purple,
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
                    onPressed: _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purple,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Submit Request",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: textDark,
      ),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: _selectDate,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? "dd/mm/yyyy"
                  : "${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: selectedDate == null ? Color(0xff1E293B) : textDark,
              ),
            ),
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: textGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperColumn({
    required String label,
    required String prefix,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Container(
                width: 44,
                height: double.infinity,
                color: Color(0xffF8FAFC),
                alignment: Alignment.center,
                child: Text(
                  prefix,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1E293B),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "$value",
                    style: GoogleFonts.inter(fontSize: 14, color: textDark),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onIncrement,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 16,
                        color: textGrey,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onDecrement,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: textGrey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ],
    );
  }
}
