import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/EmployeeManagment/employee_Employee_Details_Screen.dart';
import '../EmployeeManagment/Data/employee_Home_Card_Data.dart';

class EmployeeHomeScreenCard extends StatelessWidget {
  const EmployeeHomeScreenCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              final isKeyboardOpen =
                  MediaQuery.of(context).viewInsets.bottom > 0;

              if (isKeyboardOpen) {
                FocusScope.of(context).unfocus();

                await Future.delayed(const Duration(milliseconds: 100));
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EmployeeEmployeeDetailsScreen(employee: employee),
                ),
              );
            },
            child: Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/Doctor.png",
                          width: 20,
                          height: 20,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: employee.name,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                TextSpan(
                                  text: " · ${employee.id}",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF6B7280),
                                  ),
                                ),
                                TextSpan(
                                  text: " · ${employee.gender.toUpperCase()}",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: employee.isActive
                                ? const Color(0xFFDCFCE7)
                                : const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            employee.isActive ? "Active" : "Inactive",
                            style: GoogleFonts.inter(
                              color: employee.isActive
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFFDC2626),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Divider(color: Color(0xFFE5E7EB)),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        Expanded(
                          child: _InfoItem(
                            title: "Email Address",
                            value: employee.email,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: _InfoItem(
                            title: "Mobile Number",
                            value: employee.mobile,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _InfoItem(
                            title: "Position",
                            value: employee.position,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: _InfoItem(
                            title: "Department",
                            value: employee.department,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _InfoItem(
                            title: "Years of Service",
                            value: employee.yearsOfService,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: _InfoItem(
                            title: "Join Date",
                            value: employee.joinDate,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}
