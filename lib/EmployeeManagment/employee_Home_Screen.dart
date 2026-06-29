import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Announcement/announcement_Home_Screen.dart';
import 'package:hrms/Complaint/complaint_Home_Screen.dart';
import 'package:hrms/EmployeeManagment/employee_Home_Screen_Card.dart';
import 'package:hrms/Employee_Module_All_Screen/Account/employee_Account_Main_Screen.dart';
import 'package:hrms/Employee_Module_All_Screen/Account/employee_Account_Notification.dart';
import 'package:hrms/Employee_Module_All_Screen/ComplaintsScreen/employee_Complaints_Screen.dart';
import 'package:hrms/Employee_Module_All_Screen/leave_Management_Home_Screen.dart';
import 'package:hrms/LeavesManagment/leace_Home_Screen.dart';
import 'package:hrms/Login&SignIn/employee_Login_Page.dart';
import 'package:hrms/Overtime(Admin%20View)/admin_Overtime_HomeScreen.dart';
import 'package:hrms/Shift%20Management/shift_Management_Screen.dart';
import '../Service/secure_storage_service.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  String firstName = "";
  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final name = await SecureStorageService.getFirstName();
    if (mounted) {
      setState(() {
        firstName = name ?? "";
      });
    }
  }

  // ── Logout: get loginId first, then call logout ──────────────────────────
  Future<void> _logout() async {
    final loginId = await SecureStorageService.getCurrentLoginId();
    if (loginId != null) {
      await SecureStorageService.logout(loginId: loginId);
    }
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const EmployeeLoginScreen()),
      (route) => false, // clear entire stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      // ── Drawer ────────────────────────────────────────────────────────
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  const Text("Menu"),
                  const Spacer(),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      "assets/images/Close Icon.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.event_note),
              title: const Text("Leave Home Screen"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LeaceHomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.campaign),
              title: const Text("Announcement Page"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AnnouncementHomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text("Shift Management"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ShiftManagementScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.compare_outlined),
              title: const Text("Complaint Home Screen"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ComplaintHomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text("Admin Overtime Home screen"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AdminOvertimeHomescreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_max),
              title: const Text(
                "Leave Management Home Screen for Employee Module",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LeaveManagementHomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.computer),
              title: const Text(
                "Employee Complaints Home Screen for Employee Module",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EmployeeComplaintsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: const Text("Employee Account Main Screen"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EmployeeAccountMainScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // ── AppBar ────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Row(
          children: [
            Text("Hello $firstName"),
            const SizedBox(width: 12),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeAccountNotification(),
                  ),
                );
              }, // ✅ calls _logout() which fetches loginId first
              child: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        toolbarHeight: 60,
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),

      // ── Body ──────────────────────────────────────────────────────────
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 10,
                    bottom: 10,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    textInputAction: TextInputAction.done,
                    // onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      hintText: "Search by name or ID...",
                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xFF334155),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          bottom: 12,
                          right: 8,
                          top: 12,
                        ),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            "assets/images/search-status.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                          color: Color(0xFFE5E7EB),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const EmployeeHomeScreenCard(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),

      // ── Bottom Bar ────────────────────────────────────────────────────
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFE0DCFA),
                    foregroundColor: const Color(0xFF644EE5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Upload CSV"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF644EE5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Export CSV"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
