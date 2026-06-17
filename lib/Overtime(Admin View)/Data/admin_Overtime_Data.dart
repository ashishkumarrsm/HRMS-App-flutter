class OvertimeRecord {
  final String employeeName;
  final String employeeId;
  final String gender;
  final String department;
  final String workDate;
  final String actualWorkHrs;
  final String overtimeRequest;
  final String actualOvertime;
  final String status; // 'Pending', 'Approved', 'Rejected'
  final String description;
  final String punchIn;
  final String punchOut;
  final String totalWorkTime;

  OvertimeRecord({
    required this.employeeName,
    required this.employeeId,
    required this.gender,
    required this.department,
    required this.workDate,
    required this.actualWorkHrs,
    required this.overtimeRequest,
    required this.actualOvertime,
    required this.status,
    required this.description,
    required this.punchIn,
    required this.punchOut,
    required this.totalWorkTime,
  });
}

final List<OvertimeRecord> dummyOvertimeList = [
  OvertimeRecord(
    employeeName: "Dr. Sarah Jhonson",
    employeeId: "ID1234",
    department: "Cardiology",
    gender: "MALE",
    workDate: "15 Mar 2026",
    actualWorkHrs: "10:20 hrs",
    overtimeRequest: "2:30 hrs",
    actualOvertime: "04:20 hrs",
    status: "Pending",
    punchIn: "08:34 am",
    punchOut: "08:34 pm",
    totalWorkTime: "08:34 pm",
    description:
        "I worked overtime on these dates due to an increased workload and would like to request approval for those extra hours.",
  ),
  OvertimeRecord(
    employeeName: "Dr. Sarah Jhonson",
    employeeId: "ID1234",
    department: "Cardiology",
    workDate: "15 Mar 2026",
    gender: "MALE",
    actualWorkHrs: "10:20 hrs",
    overtimeRequest: "2:30 hrs",
    actualOvertime: "04:20 hrs",
    status: "Approved",
    punchIn: "08:34 am",
    punchOut: "08:34 pm",
    totalWorkTime: "08:34 pm",
    description:
        "I worked overtime on these dates due to an increased workload and would like to request approval for those extra hours.",
  ),
  OvertimeRecord(
    employeeName: "Dr. Sarah Jhonson",
    employeeId: "ID1234",
    department: "Cardiology",
    workDate: "15 Mar 2026",
    actualWorkHrs: "10:20 hrs",

    gender: "MALE",

    overtimeRequest: "2:30 hrs",
    actualOvertime: "04:20 hrs",
    status: "Rejected",
    punchIn: "08:34 am",
    punchOut: "08:34 pm",
    totalWorkTime: "08:34 pm",
    description:
        "I worked overtime on these dates due to an increased workload and would like to request approval for those extra hours.",
  ),
];
