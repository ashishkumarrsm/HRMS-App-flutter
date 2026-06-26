import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Employee_Module_All_Screen/Account/employee_account_Setting_Notifications.dart';

class EmployeeAccountSettings extends StatefulWidget {
  const EmployeeAccountSettings({super.key});

  @override
  State<EmployeeAccountSettings> createState() =>
      _EmployeeAccountSettingsState();
}

class _EmployeeAccountSettingsState extends State<EmployeeAccountSettings> {
  // ✅ Selected theme track karne ke liye
  String selectedTheme = "System Default";

  // ✅ Bottom sheet show karna
  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // ✅ StatefulBuilder use kiya taaki sheet ke andar bhi setState kaam kare
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Sheet Handle ──
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xffE2E8F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // ── Theme Options ──
                  ...["System Default", "Light", "Dark"].map((theme) {
                    final bool isSelected = selectedTheme == theme;

                    // Icon per theme

                    return GestureDetector(
                      onTap: () {
                        setSheetState(() {}); // sheet ke andar UI update
                        setState(() {
                          selectedTheme = theme; // bahar bhi update
                        });
                        Navigator.pop(context); // sheet band
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected
                                  ? const Color(0xffF5F0FF)
                                  : const Color(0xffF5F0FF),
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              theme,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? const Color(0xff1E293B)
                                    : const Color(0xff1E293B),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

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
            "Setting",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xff1F2937),
            ),
          ),
        ),
        toolbarHeight: 60,
        shape: const Border(
          bottom: BorderSide(color: Color(0xffE2E8F0), width: 1),
        ),
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Notifications ──
            InkWell(
              onTap: () {
                // Notification page

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeAccountSettingNotifications(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/Setting.png",
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Notifications",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff1E293B),
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      "assets/images/arrow-right.png",
                      width: 18,
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Appearance ──
            InkWell(
              onTap: showThemeBottomSheet, // ✅ bottom sheet open
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xffE2E8F0), width: 1),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/Document.png",
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Appearance",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff1E293B),
                      ),
                    ),
                    const Spacer(),
                    // ✅ Live update hoga jab theme change hogi
                    Text(
                      selectedTheme,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff94A3B8),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      "assets/images/arrow-right.png",
                      width: 18,
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
