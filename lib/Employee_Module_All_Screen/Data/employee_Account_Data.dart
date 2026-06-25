class EmployeeAccount {
  final String fullName;
  final String employeeId;
  final String designation;
  final String department;
  final String profileImage;

  final String dateOfBirth;
  final String gender;
  final String joiningDate;
  final String mobileNumber;
  final String emailAddress;
  final String position;
  final String yearsOfService;

  final String permanentAddress;
  final String currentAddress;

  EmployeeAccount({
    required this.fullName,
    required this.employeeId,
    required this.designation,
    required this.department,
    required this.profileImage,
    required this.dateOfBirth,
    required this.gender,
    required this.joiningDate,
    required this.mobileNumber,
    required this.emailAddress,
    required this.position,
    required this.yearsOfService,
    required this.permanentAddress,
    required this.currentAddress,
  });
}

/// Dummy Employee Data
final EmployeeAccount employeeAccount = EmployeeAccount(
  fullName: "Dr. Ashish Kumar",
  employeeId: "ID1234",
  designation: "Senior Physician",
  department: "Cardiology",
  profileImage: "assets/images/profileImage.jpg",

  dateOfBirth: "07 Aug 1988",
  gender: "Female",
  joiningDate: "15 Mar 2022",
  mobileNumber: "7435676570",
  emailAddress: "sarah.johnson@hospital.com",
  position: "Senior Physician",
  yearsOfService: "6 Years",

  permanentAddress: "123 Main Street, New York",
  currentAddress: "456 Elm Street, Cityville",
);
