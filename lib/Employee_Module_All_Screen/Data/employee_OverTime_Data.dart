class OvertimeRequestModel {
  final String workDate;
  final String overtimeTime;
  final String description;
  final String status;
  final String? approvedAmount;
  final String? rejectionReason;

  OvertimeRequestModel({
    required this.workDate,
    required this.overtimeTime,
    required this.description,
    required this.status,
    this.approvedAmount,
    this.rejectionReason,
  });
}

final List<OvertimeRequestModel> pendingRequests = [
  OvertimeRequestModel(
    workDate: "12 Mar 2026",
    overtimeTime: "02:00 Hrs",
    status: "Pending",
    description:
        "I worked overtime on these dates due to an increased workload and would like to request approval for these extra hours.",
  ),
  OvertimeRequestModel(
    workDate: "15 Mar 2026",
    overtimeTime: "01:30 Hrs",
    status: "Pending",
    description:
        "Stayed beyond office hours to complete urgent project deliverables.",
  ),
  OvertimeRequestModel(
    workDate: "18 Mar 2026",
    overtimeTime: "03:00 Hrs",
    status: "Pending",
    description: "Worked additional hours to support deployment activities.",
  ),
  OvertimeRequestModel(
    workDate: "20 Mar 2026",
    overtimeTime: "02:15 Hrs",
    status: "Pending",
    description: "Completed pending client tasks after working hours.",
  ),
];
final List<OvertimeRequestModel> approvedRequests = [
  OvertimeRequestModel(
    workDate: "12 Mar 2026",
    overtimeTime: "02:00 Hrs",
    status: "Approved",
    approvedAmount: "₹2000",
    description:
        "I worked overtime on these dates due to an increased workload and would like to request approval for these extra hours.",
  ),
  OvertimeRequestModel(
    workDate: "14 Mar 2026",
    overtimeTime: "01:30 Hrs",
    status: "Approved",
    approvedAmount: "₹1500",
    description: "Completed urgent support activities after office hours.",
  ),
  OvertimeRequestModel(
    workDate: "18 Mar 2026",
    overtimeTime: "02:30 Hrs",
    status: "Approved",
    approvedAmount: "₹2500",
    description: "Worked on deployment and production monitoring.",
  ),
  OvertimeRequestModel(
    workDate: "22 Mar 2026",
    overtimeTime: "03:00 Hrs",
    status: "Approved",
    approvedAmount: "₹3000",
    description:
        "Handled critical client requirements during non-working hours.",
  ),
];
final List<OvertimeRequestModel> rejectedRequests = [
  OvertimeRequestModel(
    workDate: "12 Mar 2026",
    overtimeTime: "02:00 Hrs",
    status: "Rejected",
    description:
        "I worked overtime on these dates due to an increased workload and would like to request approval for these extra hours.",
    rejectionReason:
        "The overtime hours submitted do not align with project timelines and budget constraints. Please prioritize tasks within regular working hours.",
  ),
  OvertimeRequestModel(
    workDate: "16 Mar 2026",
    overtimeTime: "01:30 Hrs",
    status: "Rejected",
    description:
        "Worked after office hours for internal documentation updates.",
    rejectionReason:
        "Overtime request cannot be approved without prior manager approval.",
  ),
  OvertimeRequestModel(
    workDate: "20 Mar 2026",
    overtimeTime: "02:45 Hrs",
    status: "Rejected",
    description: "Additional work was completed during weekend hours.",
    rejectionReason: "Weekend overtime requires pre-approved authorization.",
  ),
];
final List<OvertimeRequestModel> notRequestedData = [
  OvertimeRequestModel(
    workDate: "25 Mar 2026",
    overtimeTime: "01:30 Hrs",
    status: "Not Requested",
    description:
        "Extra hours worked but overtime request has not been submitted yet.",
  ),
  OvertimeRequestModel(
    workDate: "28 Mar 2026",
    overtimeTime: "02:00 Hrs",
    status: "Not Requested",
    description:
        "Worked late for release preparation. Request pending submission.",
  ),
];