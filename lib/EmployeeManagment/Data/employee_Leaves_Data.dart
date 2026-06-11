class EmployeeLeave {
  final String employeeId;
  final String leaveType;
  final int usedLeaves;
  final int totalLeaves;
  final String validity;
  final String note;
  final bool canApply;

  EmployeeLeave({
    required this.employeeId,
    required this.leaveType,
    required this.usedLeaves,
    required this.totalLeaves,
    required this.validity,
    required this.note,
    this.canApply = false,
  });
}

List<EmployeeLeave> employeeLeaves = [
  // EMP001 - Ashish Kumar
  EmployeeLeave(
    employeeId: "EMP001",
    leaveType: "Casual Leave (CL)",
    usedLeaves: 10,
    totalLeaves: 13,
    validity: "Jul-Dec",
    note: "26 per year (13/half-year)",
  ),

  EmployeeLeave(
    employeeId: "EMP001",
    leaveType: "Restricted Leave (RH)",
    usedLeaves: 2,
    totalLeaves: 3,
    validity: "Jan-Dec",
    note: "3 days per calendar year",
  ),

  EmployeeLeave(
    employeeId: "EMP001",
    leaveType: "Comp Off Leave",
    usedLeaves: 0,
    totalLeaves: 1,
    validity: "Jan-Feb",
    note: "Valid 2 months from earned date",
    canApply: true,
  ),

  // EMP002
  EmployeeLeave(
    employeeId: "EMP002",
    leaveType: "Casual Leave (CL)",
    usedLeaves: 7,
    totalLeaves: 13,
    validity: "Jul-Dec",
    note: "26 per year (13/half-year)",
  ),

  EmployeeLeave(
    employeeId: "EMP002",
    leaveType: "Restricted Leave (RH)",
    usedLeaves: 1,
    totalLeaves: 3,
    validity: "Jan-Dec",
    note: "3 days per calendar year",
  ),

  // EMP003
  EmployeeLeave(
    employeeId: "EMP003",
    leaveType: "Casual Leave (CL)",
    usedLeaves: 13,
    totalLeaves: 13,
    validity: "Jul-Dec",
    note: "Leave Exhausted",
  ),

  EmployeeLeave(
    employeeId: "EMP003",
    leaveType: "Medical Leave",
    usedLeaves: 5,
    totalLeaves: 10,
    validity: "Jan-Dec",
    note: "Annual entitlement",
  ),

  // EMP004
  EmployeeLeave(
    employeeId: "EMP004",
    leaveType: "Casual Leave (CL)",
    usedLeaves: 4,
    totalLeaves: 13,
    validity: "Jul-Dec",
    note: "26 per year (13/half-year)",
  ),

  EmployeeLeave(
    employeeId: "EMP004",
    leaveType: "Restricted Leave (RH)",
    usedLeaves: 0,
    totalLeaves: 3,
    validity: "Jan-Dec",
    note: "3 days per calendar year",
  ),

  // EMP005
  EmployeeLeave(
    employeeId: "EMP005",
    leaveType: "Casual Leave (CL)",
    usedLeaves: 8,
    totalLeaves: 13,
    validity: "Jul-Dec",
    note: "26 per year (13/half-year)",
  ),

  // EMP006
  EmployeeLeave(
    employeeId: "EMP006",
    leaveType: "Maternity Leave",
    usedLeaves: 30,
    totalLeaves: 90,
    validity: "Jan-Dec",
    note: "90 days entitlement",
  ),

  // EMP007
  EmployeeLeave(
    employeeId: "EMP007",
    leaveType: "Casual Leave (CL)",
    usedLeaves: 2,
    totalLeaves: 13,
    validity: "Jul-Dec",
    note: "26 per year (13/half-year)",
  ),

  // EMP008
  EmployeeLeave(
    employeeId: "EMP008",
    leaveType: "Casual Leave (CL)",
    usedLeaves: 0,
    totalLeaves: 13,
    validity: "Jul-Dec",
    note: "New Employee",
  ),

  // EMP009
  EmployeeLeave(
    employeeId: "EMP009",
    leaveType: "Casual Leave (CL)",
    usedLeaves: 9,
    totalLeaves: 13,
    validity: "Jul-Dec",
    note: "26 per year (13/half-year)",
  ),

  // EMP010
  EmployeeLeave(
    employeeId: "EMP010",
    leaveType: "Casual Leave (CL)",
    usedLeaves: 11,
    totalLeaves: 13,
    validity: "Jul-Dec",
    note: "26 per year (13/half-year)",
  ),
];