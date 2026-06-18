class LeaveBalanceModel {
  final String leaveType;
  final int usedDays;
  final int totalDays;
  final String validity;
  final String leftNote;
  final String rightNote;

  LeaveBalanceModel({
    required this.leaveType,
    required this.usedDays,
    required this.totalDays,
    required this.validity,
    required this.leftNote,
    required this.rightNote,
  });
}


final List<LeaveBalanceModel> leaveBalanceData = [
  LeaveBalanceModel(
    leaveType: "Casual Leave (CL)",
    usedDays: 10,
    totalDays: 13,
    validity: "Jul-Dec",
    leftNote: "No Carry Forward",
    rightNote: "26 per year (13/half-year)",
  ),

  LeaveBalanceModel(
    leaveType: "Restricted Leave (RH)",
    usedDays: 2,
    totalDays: 3,
    validity: "Jan-Dec",
    leftNote: "No Carry Forward",
    rightNote: "3 days per calendar year",
  ),

  LeaveBalanceModel(
    leaveType: "Comp Off Leave",
    usedDays: 0,
    totalDays: 1,
    validity: "Jan-Feb",
    leftNote: "Short Validity",
    rightNote: "Valid 2 months from earned date",
  ),
];