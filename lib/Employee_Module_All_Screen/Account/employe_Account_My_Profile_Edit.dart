import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Data/employee_Account_Data.dart';

class EmployeeAccountMyProfileEdit extends StatefulWidget {
  const EmployeeAccountMyProfileEdit({super.key});

  @override
  State<EmployeeAccountMyProfileEdit> createState() =>
      _EmployeeAccountMyProfileEditState();
}

class _EmployeeAccountMyProfileEditState
    extends State<EmployeeAccountMyProfileEdit> {
  File? selectedImage;

  final TextEditingController dobController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // ✅ Alag-alag state har dropdown ke liye
  String? selectedGender;
  String? selectedPosition;
  String? selectDepartment;

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}/"
          "${pickedDate.month.toString().padLeft(2, '0')}/"
          "${pickedDate.year}";

      setState(() {
        dobController.text = formattedDate;
      });
    }
  }

  @override
  void dispose() {
    dobController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Widget dateSelect() {
    return TextFormField(
      controller: dobController,
      readOnly: true,
      onTap: selectDate,
      decoration: InputDecoration(
        hintText: "dd/mm/yyyy",
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xff667085),
        ),
        suffixIcon: IconButton(
          onPressed: selectDate,
          icon: Image.asset(
            "assets/images/Calender.png",
            width: 16,
            height: 16,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xffD0D5DD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xffD0D5DD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xff7F56D9)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xff1F2937),
          ),
        ),
        shape: const Border(
          bottom: BorderSide(color: Color(0xffE2E8F0), width: 1),
        ),
      ),

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// PROFILE SECTION
                Row(
                  children: [
                    Container(
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
                            ? FileImage(selectedImage!)
                            : const AssetImage("assets/images/profileImage.jpg")
                                  as ImageProvider,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employeeAccount.fullName,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            children: [
                              Text(
                                employeeAccount.employeeId,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xff697586),
                                ),
                              ),
                              Text(
                                " • ${employeeAccount.designation}",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xff697586),
                                ),
                              ),
                              Text(
                                " • ${employeeAccount.department}",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xff697586),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Information",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff1F2937),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(),

                    // ── Date of Birth ──
                    _sectionField(label: "Date of Birth", child: dateSelect()),

                    const Divider(),

                    // ── Gender ──
                    _sectionField(
                      label: "Gender",
                      child: customDropdown(
                        value: selectedGender, // ✅ apni state
                        items: const ["Male", "Female", "Other"],
                        onChanged: (value) {
                          setState(() => selectedGender = value);
                        },
                      ),
                    ),

                    const Divider(),

                    // ── Mobile Number ──
                    _sectionField(
                      label: "Mobile Number",
                      child: _buildTextField(
                        controller: mobileController,
                        hint: "Enter Mobile Number",
                        keyboardType: TextInputType.phone,
                      ),
                    ),

                    const Divider(),

                    // ── Email Address ──
                    _sectionField(
                      label: "Email Address",
                      child: _buildTextField(
                        controller: emailController,
                        hint: "Enter Email Address",
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),

                    const Divider(),

                    // ── Position ──
                    _sectionField(
                      label: "Position",
                      child: customDropdown(
                        value: selectedPosition, // ✅ apni state
                        items: const [
                          "Flutter Developer",
                          "Backend Developer",
                          "Designer",
                          "Manager",
                        ],
                        onChanged: (value) {
                          setState(() => selectedPosition = value);
                        },
                      ),
                    ),

                    const Divider(),

                    // ── Position ──
                    _sectionField(
                      label: "Department",
                      child: customDropdown(
                        value: selectDepartment, // ✅ apni state
                        items: const [
                          "Flutter Developer",
                          "Backend Developer",
                          "Designer",
                          "Manager",
                        ],
                        onChanged: (value) {
                          setState(() => selectDepartment = value);
                        },
                      ),
                    ),

                    Divider(),
                    // ── Years of Service ──
                    _sectionField(
                      label: "Years of Service",
                      child: _buildTextField(
                        controller: emailController,
                        hint: "Enter years of service",
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),

                    Divider(),
                  ],
                ),

                const SizedBox(height: 24),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address Details",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff1F2937),
                      ),
                    ),
                    const SizedBox(height: 8),

                    const Divider(),

                    // ── Mobile Number ──
                    _sectionField(
                      label: "Permanent Address",
                      child: Text(
                        "123 Main Street",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Divider(),
                    // ── Current Address──
                    _sectionField(
                      label: "Current Address",
                      child: _buildTextField(
                        controller: addressController,
                        hint: "Enter Current Address",
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xffE2E8F0), width: 1)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Save Logic
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Color(0xff644EE5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Helper: label + child wrapper ──
  Widget _sectionField({required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xff27272A),
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  // ── Helper: common TextField ──
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,

    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,

      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xff667085),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xffE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xffE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xffE2E8F0)),
        ),
      ),
    );
  }
}

// ── Reusable Dropdown (sirf UI, value bahar se aata hai) ──
Widget customDropdown({
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    isExpanded: true,
    dropdownColor: Colors.white,
    decoration: InputDecoration(
      hintText: "Select",
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        color: const Color(0xff667085),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffE2E8F0)),
      ),
    ),
    items: items.map((item) {
      return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xff1F2937),
          ),
        ),
      );
    }).toList(),
    onChanged: onChanged,
  );
}
