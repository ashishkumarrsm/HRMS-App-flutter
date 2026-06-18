import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Data/employee_Leave_Card_Data.dart';

class EmployeeMyLeaveCard extends StatelessWidget {
  final LeaveBalanceModel leave;

  const EmployeeMyLeaveCard({super.key, required this.leave});

  @override
  Widget build(BuildContext context) {
    final double progress = leave.totalDays == 0
        ? 0
        : leave.usedDays / leave.totalDays;

    return Container(
      // margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
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
                      text: "${leave.usedDays}",
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF273043),
                      ),
                    ),
                    TextSpan(
                      text: " / ${leave.totalDays} Days",
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

          const SizedBox(height: 12),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF8B5CF6)),
            ),
          ),

          const SizedBox(height: 12),

          // Footer
          Row(
            children: [
              Text(
                leave.leftNote,
                style: GoogleFonts.inter(
                  color: const Color(0xFFDC2626),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

              Text(
                leave.rightNote,
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
