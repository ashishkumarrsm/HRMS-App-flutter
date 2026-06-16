class OvertimeRecord {
  final String employeeName;
  final String employeeId;
  final String status;
  final String workDate;
  final String requestedOvertime;
  final String actualOvertime;
  final String punchIn;
  final String punchOut;
  final String totalWorkTime;
  final String description;

  OvertimeRecord({
    required this.employeeName,
    required this.employeeId,
    required this.status,
    required this.workDate,
    required this.requestedOvertime,
    required this.actualOvertime,
    required this.punchIn,
    required this.punchOut,
    required this.totalWorkTime,
    required this.description,
  });
}

List<OvertimeRecord> overtimeData = [
  OvertimeRecord(
    employeeName: "Dr. Sarah Johnson",
    employeeId: "ID1234",
    status: "Requested",
    workDate: "12 Mar 2026",
    requestedOvertime: "02:30 Hrs",
    actualOvertime: "02:00 Hrs",
    punchIn: "08:30 AM",
    punchOut: "08:30 PM",
    totalWorkTime: "12:00 Hrs",
    description:
        "I worked overtime due to an increased workload and would like approval for these extra hours.",
  ),

  OvertimeRecord(
    employeeName: "Ashish Kumar",
    employeeId: "ID1235",
    status: "Approved",
    workDate: "14 Mar 2026",
    requestedOvertime: "03:00 Hrs",
    actualOvertime: "03:00 Hrs",
    punchIn: "09:00 AM",
    punchOut: "09:00 PM",
    totalWorkTime: "12:00 Hrs",
    description: "Completed urgent employee management module before deadline.",
  ),

  OvertimeRecord(
    employeeName: "Michael Brown",
    employeeId: "ID1236",
    status: "Rejected",
    workDate: "16 Mar 2026",
    requestedOvertime: "01:30 Hrs",
    actualOvertime: "01:00 Hrs",
    punchIn: "08:00 AM",
    punchOut: "06:30 PM",
    totalWorkTime: "10:30 Hrs",
    description: "Worked on monthly reporting tasks after office hours.",
  ),

  OvertimeRecord(
    employeeName: "Emily Davis",
    employeeId: "ID1237",
    status: "Requested",
    workDate: "18 Mar 2026",
    requestedOvertime: "02:00 Hrs",
    actualOvertime: "01:45 Hrs",
    punchIn: "09:00 AM",
    punchOut: "08:45 PM",
    totalWorkTime: "11:45 Hrs",
    description: "Needed extra time to complete payroll verification process.",
  ),

  OvertimeRecord(
    employeeName: "David Wilson",
    employeeId: "ID1238",
    status: "Approved",
    workDate: "20 Mar 2026",
    requestedOvertime: "04:00 Hrs",
    actualOvertime: "03:30 Hrs",
    punchIn: "08:30 AM",
    punchOut: "09:00 PM",
    totalWorkTime: "12:30 Hrs",
    description: "Handled critical production deployment during evening hours.",
  ),

  OvertimeRecord(
    employeeName: "Olivia Martin",
    employeeId: "ID1239",
    status: "Requested",
    workDate: "22 Mar 2026",
    requestedOvertime: "01:00 Hrs",
    actualOvertime: "01:00 Hrs",
    punchIn: "09:00 AM",
    punchOut: "07:00 PM",
    totalWorkTime: "10:00 Hrs",
    description: "Resolved pending customer support escalations.",
  ),

  OvertimeRecord(
    employeeName: "James Anderson",
    employeeId: "ID1240",
    status: "Approved",
    workDate: "24 Mar 2026",
    requestedOvertime: "02:15 Hrs",
    actualOvertime: "02:00 Hrs",
    punchIn: "08:00 AM",
    punchOut: "08:15 PM",
    totalWorkTime: "12:15 Hrs",
    description: "Completed backend API integration and testing.",
  ),

  OvertimeRecord(
    employeeName: "Sophia Taylor",
    employeeId: "ID1241",
    status: "Rejected",
    workDate: "26 Mar 2026",
    requestedOvertime: "02:45 Hrs",
    actualOvertime: "02:00 Hrs",
    punchIn: "09:00 AM",
    punchOut: "08:00 PM",
    totalWorkTime: "11:00 Hrs",
    description: "Stayed late to finish documentation and project handover.",
  ),

  OvertimeRecord(
    employeeName: "Daniel Thomas",
    employeeId: "ID1242",
    status: "Requested",
    workDate: "28 Mar 2026",
    requestedOvertime: "03:30 Hrs",
    actualOvertime: "03:00 Hrs",
    punchIn: "08:30 AM",
    punchOut: "09:30 PM",
    totalWorkTime: "13:00 Hrs",
    description: "Worked on urgent bug fixes reported by QA team.",
  ),

  OvertimeRecord(
    employeeName: "Emma Garcia",
    employeeId: "ID1243",
    status: "Approved",
    workDate: "30 Mar 2026",
    requestedOvertime: "02:00 Hrs",
    actualOvertime: "02:00 Hrs",
    punchIn: "09:00 AM",
    punchOut: "08:00 PM",
    totalWorkTime: "11:00 Hrs",
    description: "Assisted in completing financial reconciliation tasks.",
  ),
];
