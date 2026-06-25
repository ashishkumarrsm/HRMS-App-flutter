import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Employee_Module_All_Screen/Account/employe_Account_My_Profile_Edit.dart';
import '../Data/employee_Account_Data.dart';

class EmployeeAccountMyProfile extends StatefulWidget {
  const EmployeeAccountMyProfile({super.key});

  @override
  State<EmployeeAccountMyProfile> createState() =>
      _EmployeeAccountMyProfileState();
}

class _EmployeeAccountMyProfileState extends State<EmployeeAccountMyProfile> {
  // Image picker se aane wali image
  File? selectedImage;

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
            "My Profile",
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                            : const AssetImage(
                                "assets/images/profileImage.jpg",
                              ),
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal Information",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1F2937),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 8),
                      Divider(),

                      Detail("Date of Birth", employeeAccount.dateOfBirth),
                      Divider(),

                      Detail("Gender", employeeAccount.gender),
                      Divider(),

                      Detail("Join Date", employeeAccount.joiningDate),
                      Divider(),

                      Detail("Mobile Number", employeeAccount.mobileNumber),
                      Divider(),

                      Detail("Email Address", employeeAccount.emailAddress),
                      Divider(),

                      Detail("Position", employeeAccount.position),
                      Divider(),

                      Detail("Department", employeeAccount.department),
                      Divider(),

                      Detail(
                        "Years of Service",
                        employeeAccount.yearsOfService,
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: 24),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address Details",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1F2937),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 8),
                      Divider(),

                      Detail(
                        "Permanent Address",
                        employeeAccount.permanentAddress,
                      ),
                      Divider(),

                      Detail("Current Address", employeeAccount.currentAddress),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xffE2E8F0), width: 1)),
        ),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeAccountMyProfileEdit(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xffEDE9FE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Edit",
              style: TextStyle(
                color: Color(0xff644EE5),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget Detail(String titel, String Data) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titel,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff71717A),
          ),
        ),
        SizedBox(height: 12),
        Text(
          Data,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff1E293B),
          ),
        ),
      ],
    ),
  );
}
