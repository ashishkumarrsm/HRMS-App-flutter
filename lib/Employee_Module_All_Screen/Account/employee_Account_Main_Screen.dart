import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Employee_Module_All_Screen/Account/employee_Account_My_Profile.dart';
import 'package:hrms/Employee_Module_All_Screen/Account/employee_Account_Settings.dart';
import 'package:hrms/Login&SignIn/employee_Login_Page.dart';
import 'package:hrms/Service/secure_storage_service.dart';
import '../Data/employee_Account_Data.dart';

class EmployeeAccountMainScreen extends StatefulWidget {
  const EmployeeAccountMainScreen({super.key});

  @override
  State<EmployeeAccountMainScreen> createState() =>
      _EmployeeAccountMainScreenState();
}

class _EmployeeAccountMainScreenState extends State<EmployeeAccountMainScreen> {
  // Image picker se aane wali image
  File? selectedImage;
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
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Align(
          alignment: AlignmentGeometry.centerStart,
          child: Text(
            "Profile",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff1F2937),
            ),
            textAlign: TextAlign.start,
          ),
        ),
        toolbarHeight: 60,
        shape: const Border(
          bottom: BorderSide(color: Color(0xffE2E8F0), width: 1),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //! Profile Image & Details Section
              Row(
                children: [
                  Container(
                    // padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffE9D5FF),
                        width: 5,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!) as ImageProvider
                          : const AssetImage("assets/images/profileImage.jpg"),
                    ),
                  ),

                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employeeAccount.fullName,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      Row(
                        children: [
                          Text(
                            employeeAccount.employeeId,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff697586),
                            ),
                          ),
                          Text(
                            " • ${employeeAccount.designation} ",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff697586),
                            ),
                          ),
                          Text(
                            "• ${employeeAccount.department}",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff697586),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 24),

              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        profileMenuTile(
                          icon: "assets/images/Profile.png",
                          title: "My Profile",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeAccountMyProfile(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8),
                        profileMenuTile(
                          icon: "assets/images/Setting.png",
                          title: "Setting",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmployeeAccountSettings(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        profileMenuTile(
                          icon: "assets/images/Document.png",
                          title: "Terms & conditions ",
                          onTap: () {},
                        ),
                        SizedBox(height: 8),
                        profileMenuTile(
                          icon: "assets/images/Document.png",
                          title: "Privacy Policy ",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap:
                              _logout, // ✅ calls _logout() which fetches loginId first
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 24,
                                  color: Color(0xffDC2626),
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  "Logout",
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xffDC2626),
                                  ),
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
        ),
      ),
    );
  }
}

Widget profileMenuTile({
  required String icon,
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Image.asset(icon, width: 24, height: 24),

          const SizedBox(width: 8),

          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xff1E293B),
            ),
          ),

          const Spacer(),

          Image.asset("assets/images/arrow-right.png", width: 18, height: 18),
        ],
      ),
    ),
  );
}
