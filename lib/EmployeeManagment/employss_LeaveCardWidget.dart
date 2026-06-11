import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../EmployeeManagment/Data/employee_Leaves_Data.dart';

class LeaveCard extends StatelessWidget {
  final EmployeeLeave leave;

  const LeaveCard({super.key, required this.leave});

  @override
  Widget build(BuildContext context) {
    final double progress = leave.totalLeaves == 0
        ? 0
        : leave.usedLeaves / leave.totalLeaves;

    return Container(
      // margin: const EdgeInsets.only(bottom: 20, top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  leave.leaveType,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF273043),
                  ),
                ),
              ),

              if (leave.canApply)
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF644EE5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Apply CO Leave",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          const Divider(),

          const SizedBox(height: 20),

          // Leave Count + Validity
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${leave.usedLeaves}",
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF273043),
                      ),
                    ),
                    TextSpan(
                      text: " / ${leave.totalLeaves} Days",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF273043),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              Text(
                leave.validity,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF273043),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF7C5CFA)),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(height: 8),

          // Footer
          Row(
            children: [
              Text(
                leave.canApply ? "Short Validity" : "No Carry Forward",
                style: GoogleFonts.inter(
                  color: const Color(0xFFDC2626),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

              Text(
                leave.note,
                style: GoogleFonts.inter(
                  color: const Color(0xFF64748B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
