import 'package:flutter/material.dart';

enum AttendanceStatus { present, absent, leave, late, earlyCheckout }

class AttendanceRecord {
  final DateTime date;
  final AttendanceStatus status;
  final bool hasFlag;

  const AttendanceRecord({
    required this.date,
    required this.status,
    this.hasFlag = false,
  });
}

final List<AttendanceRecord> attendanceData = [
  AttendanceRecord(
    date: DateTime(2025, 8, 1),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(date: DateTime(2025, 8, 2), status: AttendanceStatus.absent),

  AttendanceRecord(
    date: DateTime(2025, 8, 3),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 4),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 5),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 6),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 7),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 8),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 9),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 10),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 11),
    status: AttendanceStatus.absent,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 12),
    status: AttendanceStatus.absent,
    hasFlag: true,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 13),
    status: AttendanceStatus.absent,
    hasFlag: true,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 14),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(date: DateTime(2025, 8, 15), status: AttendanceStatus.leave),

  AttendanceRecord(
    date: DateTime(2025, 8, 16),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(
    date: DateTime(2025, 8, 17),
    status: AttendanceStatus.earlyCheckout,
  ),

  AttendanceRecord(date: DateTime(2025, 8, 18), status: AttendanceStatus.late),

  AttendanceRecord(
    date: DateTime(2025, 8, 19),
    status: AttendanceStatus.present,
  ),

  AttendanceRecord(date: DateTime(2025, 8, 20), status: AttendanceStatus.late),
];

Color getStatusColor(AttendanceStatus status) {
  switch (status) {
    case AttendanceStatus.present:
      return const Color(0xFFDDF4E5);

    case AttendanceStatus.absent:
      return const Color(0xFFFBE2E2);

    case AttendanceStatus.leave:
      return const Color(0xFFF8F2D9);

    case AttendanceStatus.late:
      return const Color(0xFFF3E5F5);

    case AttendanceStatus.earlyCheckout:
      return const Color(0xFFFCEAD6);
  }
}

Color getTextColor(AttendanceStatus status) {
  switch (status) {
    case AttendanceStatus.present:
      return const Color(0xFF15803D);

    case AttendanceStatus.absent:
      return const Color(0xFFDC2626);

    case AttendanceStatus.leave:
      return const Color(0xFFCA8A04);

    case AttendanceStatus.late:
      return const Color(0xFFC026D3);

    case AttendanceStatus.earlyCheckout:
      return const Color(0xFFEA580C);
  }
}
