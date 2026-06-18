class LeaveHistoryModel {
  final String leaveType;
  final String leaveCategory;
  final String startDate;
  final String endDate;
  final int requestedDays;
  final String availableLeave;
  final String appliedOn;
  final String leaveReason;
  final String documentName;
  final String documentSize;
  final String approvedBy;
  final String status;

  LeaveHistoryModel({
    required this.leaveType,
    required this.leaveCategory,
    required this.startDate,
    required this.endDate,
    required this.requestedDays,
    required this.availableLeave,
    required this.appliedOn,
    required this.leaveReason,
    required this.documentName,
    required this.documentSize,
    required this.approvedBy,
    required this.status,
  });
}

final List<LeaveHistoryModel> leaveHistoryData = [
  // Approved
  LeaveHistoryModel(
    leaveType: "Full Day",
    leaveCategory: "Casual Leave",
    startDate: "12 Mar 2026",
    endDate: "12 Mar 2026",
    requestedDays: 2,
    availableLeave: "4.5 Days",
    appliedOn: "10 Mar 2026",
    leaveReason:
        "I am writing to request a two-day leave of absence starting Mar 12th, 2026, for a family matter.",
    documentName: "14563456775.jpg",
    documentSize: "2 MB",
    approvedBy: "Mohan Singh (HOD)",
    status: "Approved",
  ),

  // Approved
  LeaveHistoryModel(
    leaveType: "Half Day",
    leaveCategory: "Medical Leave",
    startDate: "18 Apr 2026",
    endDate: "18 Apr 2026",
    requestedDays: 1,
    availableLeave: "3 Days",
    appliedOn: "17 Apr 2026",
    leaveReason: "Doctor consultation and medical checkup.",
    documentName: "medical_report.pdf",
    documentSize: "1.5 MB",
    approvedBy: "Mohan Singh (HOD)",
    status: "Approved",
  ),

  // Pending
  LeaveHistoryModel(
    leaveType: "Full Day",
    leaveCategory: "Personal Leave",
    startDate: "25 May 2026",
    endDate: "26 May 2026",
    requestedDays: 2,
    availableLeave: "3 Days",
    appliedOn: "20 May 2026",
    leaveReason: "Need leave for personal work and documentation process.",
    documentName: "request_letter.pdf",
    documentSize: "800 KB",
    approvedBy: "-",
    status: "Pending",
  ),

  // Pending
  LeaveHistoryModel(
    leaveType: "Full Day",
    leaveCategory: "Casual Leave",
    startDate: "10 Jun 2026",
    endDate: "11 Jun 2026",
    requestedDays: 2,
    availableLeave: "2 Days",
    appliedOn: "08 Jun 2026",
    leaveReason: "Family function outside city.",
    documentName: "invitation_card.jpg",
    documentSize: "1 MB",
    approvedBy: "-",
    status: "Pending",
  ),

  // Rejected
  LeaveHistoryModel(
    leaveType: "Full Day",
    leaveCategory: "Emergency Leave",
    startDate: "05 Feb 2026",
    endDate: "07 Feb 2026",
    requestedDays: 3,
    availableLeave: "1 Day",
    appliedOn: "03 Feb 2026",
    leaveReason:
        "Emergency travel request. Need leave for personal work and documentation process.",
    documentName: "travel_doc.pdf",
    documentSize: "2.5 MB",
    approvedBy: "Mohan Singh (HOD)",
    status: "Rejected",
  ),

  // Rejected
  LeaveHistoryModel(
    leaveType: "Half Day",
    leaveCategory: "Casual Leave",
    startDate: "15 Jan 2026",
    endDate: "15 Jan 2026",
    requestedDays: 1,
    availableLeave: "0.5 Day",
    appliedOn: "14 Jan 2026",
    leaveReason: "Personal work during office hours.",
    documentName: "leave_request.pdf",
    documentSize: "500 KB",
    approvedBy: "Mohan Singh (HOD)",
    status: "Rejected",
  ),
];
