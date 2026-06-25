import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeAccountSettingNotifications extends StatefulWidget {
  const EmployeeAccountSettingNotifications({super.key});

  @override
  State<EmployeeAccountSettingNotifications> createState() =>
      _EmployeeAccountSettingNotificationsState();
}

class _EmployeeAccountSettingNotificationsState
    extends State<EmployeeAccountSettingNotifications> {
  // ✅ Har item ka alag toggle state
  bool generalNotifications = true;
  bool feeAlerts = false;
  bool examUpdates = false;
  bool hostelNotifications = false;
  bool maintenanceUpdates = false;
  bool attendanceAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Notifications",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xff1F2937),
          ),
        ),
        toolbarHeight: 60,
        shape: const Border(
          bottom: BorderSide(color: Color(0xffE2E8F0), width: 1),
        ),
      ),

      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(16),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _toggleItem(
              title: "General Notifications",
              value: generalNotifications,
              onChanged: (v) => setState(() => generalNotifications = v),
              showDivider: true,
            ),
            _toggleItem(
              title: "Fee Alerts",
              value: feeAlerts,
              onChanged: (v) => setState(() => feeAlerts = v),
              showDivider: true,
            ),
            _toggleItem(
              title: "Exam Updates",
              value: examUpdates,
              onChanged: (v) => setState(() => examUpdates = v),
              showDivider: true,
            ),
            _toggleItem(
              title: "Hostel Notifications",
              value: hostelNotifications,
              onChanged: (v) => setState(() => hostelNotifications = v),
              showDivider: true,
            ),
            _toggleItem(
              title: "Maintenance Updates",
              value: maintenanceUpdates,
              onChanged: (v) => setState(() => maintenanceUpdates = v),
              showDivider: true,
            ),
            _toggleItem(
              title: "Attendance Alerts",
              value: attendanceAlerts,
              onChanged: (v) => setState(() => attendanceAlerts = v),
              showDivider: false, // last item — no divider
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),

            border: Border.all(color: const Color(0xffE5E7EB), width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff1E293B),
                  ),
                ),
              ),
              CustomToggle(value: value, onChanged: onChanged),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Custom Toggle ──
class CustomToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomToggle({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 48,
        height: 26,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: value ? const Color(0xff644EE5) : const Color(0xffD2D5DA),
          borderRadius: BorderRadius.circular(50),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
