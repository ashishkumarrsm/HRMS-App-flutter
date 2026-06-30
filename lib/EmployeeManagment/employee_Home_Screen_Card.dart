import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Models/all_Users.dart';
import 'package:hrms/api_service/api_services.dart';

class EmployeeHomeScreenCard extends StatefulWidget {
  const EmployeeHomeScreenCard({super.key});

  @override
  State<EmployeeHomeScreenCard> createState() => _EmployeeHomeScreenCardState();
}

class _EmployeeHomeScreenCardState extends State<EmployeeHomeScreenCard> {
  bool isLoading = true;
  String? errorMessage;
  AllUser? model;

  @override
  void initState() {
    super.initState();
    _getAllUser();
  }

  Future<void> _getAllUser() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final result = await ApiServices().getAllUsers();
      print(result);
      setState(() {
        model = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load employees. Please try again.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(color: Color(0xFF644EE5)),
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _getAllUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF644EE5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Retry",
                  style: GoogleFonts.inter(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ✅ Null check & empty check
    if (model == null || model!.data == null || model!.data!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            "No employees found.",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF6B7280),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: model!.data!.length,
      itemBuilder: (context, index) {
        // ✅ Typed model, index se sahi employee
        final UserData employee = model!.data![index];
        final bool isActive = (employee.status ?? '').toLowerCase() == 'active';

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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         EmployeeEmployeeDetailsScreen(employee: employee),
              //   ),
              // );
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
                                  text: employee.firstName ?? '',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                TextSpan(
                                  text: " · ${employee.id ?? ''}",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF6B7280),
                                  ),
                                ),
                                TextSpan(
                                  text: " · ${employee.lastName ?? ''}",
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
                        // ✅ Status string se bool banana
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFFDCFCE7)
                                : const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            isActive ? "Active" : "Inactive",
                            style: GoogleFonts.inter(
                              color: isActive
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
                            value: employee.email ?? '-',
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: _InfoItem(
                            title: "Mobile Number",
                            value: employee.phoneNumber ?? '-',
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
                            value: employee.role ?? '-',
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: _InfoItem(
                            title: "Department",
                            value: employee.roleName ?? '-',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _InfoItem(
                            title: "Created At",
                            value: employee.createdAt ?? '-',
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: _InfoItem(
                            title: "Last Login",
                            value: employee.lastLogin ?? '__/__/__',
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
