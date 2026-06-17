class ComplaintRecord {
  final String employeeName;
  final String gender;
  final String complaintId;
  final String complaintDate;
  final String position;
  final String department;
  final String description;
  final String status;

  ComplaintRecord({
    required this.employeeName,
    required this.gender,
    required this.complaintId,
    required this.complaintDate,
    required this.position,
    required this.department,
    required this.description,
    required this.status,
  });
}

List<ComplaintRecord> complaintList = [
  ComplaintRecord(
    employeeName: "Dr. Sarah Johnson",
    gender: "MALE",
    complaintId: "ID1234",
    complaintDate: "2022-03-15",
    position: "Senior Physician",
    department: "Cardiology",
    description:
        "I want to report a water leakage issue in my hostel room. The leak is coming from the ceiling near the bathroom.",
    status: "Pending",
  ),

  ComplaintRecord(
    employeeName: "Dr. Sarah Johnson",
    gender: "MALE",
    complaintId: "ID1235",
    complaintDate: "2022-03-15",
    position: "Senior Physician",
    department: "Cardiology",
    description:
        "I want to report a water leakage issue in my hostel room. The leak is coming from the ceiling near the bathroom.",
    status: "Approved",
  ),

  ComplaintRecord(
    employeeName: "Dr. Sarah Johnson",
    gender: "MALE",
    complaintId: "ID1236",
    complaintDate: "2022-03-15",
    position: "Senior Physician",
    department: "Cardiology",
    description:
        "I want to report a water leakage issue in my hostel room. The leak is coming from the ceiling near the bathroom.",
    status: "Rejected",
  ),

  ComplaintRecord(
    employeeName: "Dr. Emily Carter",
    gender: "FEMALE",
    complaintId: "ID1237",
    complaintDate: "2022-03-16",
    position: "Nurse",
    department: "Neurology",
    description: "Air conditioning is not working properly in the staff room.",
    status: "Pending",
  ),

  ComplaintRecord(
    employeeName: "Dr. Michael Brown",
    gender: "MALE",
    complaintId: "ID1238",
    complaintDate: "2022-03-17",
    position: "Consultant",
    department: "Orthopedics",
    description: "The elevator near Block B is frequently getting stuck.",
    status: "Approved",
  ),

  ComplaintRecord(
    employeeName: "Dr. Lisa Anderson",
    gender: "FEMALE",
    complaintId: "ID1239",
    complaintDate: "2022-03-18",
    position: "Surgeon",
    department: "Emergency",
    description: "Insufficient lighting in the hospital parking area.",
    status: "Rejected",
  ),
];
