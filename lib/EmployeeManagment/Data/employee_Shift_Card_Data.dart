class EmployeeShift {
  final String employeeId;
  final String shiftType;
  final String startTime;
  final String endTime;
  final String department;
  final String date;

  EmployeeShift({
    required this.employeeId,
    required this.shiftType,
    required this.startTime,
    required this.endTime,
    required this.department,
    required this.date,
  });
}

List<EmployeeShift> employeeShifts = [
  // EMP001 - Ashish Kumar (Doctor - Cardiology)
  EmployeeShift(
    employeeId: "EMP001",
    shiftType: "Morning",
    startTime: "08:00 AM",
    endTime: "04:00 PM",
    department: "Cardiology",
    date: "12 Mar 2026",
  ),
  
  // EMP002 - Sarah Johnson (Nurse - Emergency)
  EmployeeShift(
    employeeId: "EMP002",
    shiftType: "Evening",
    startTime: "02:00 PM",
    endTime: "10:00 PM",
    department: "Emergency",
    date: "12 Mar 2026",
  ),

  // EMP003 - Michael Brown (Doctor - Orthopedics)
  EmployeeShift(
    employeeId: "EMP003",
    shiftType: "Night",
    startTime: "10:00 PM",
    endTime: "06:00 AM",
    department: "Orthopedics",
    date: "12 Mar 2026",
  ),

  // EMP004 - Emily Davis (Administrator - Management)
  EmployeeShift(
    employeeId: "EMP004",
    shiftType: "General",
    startTime: "09:00 AM",
    endTime: "05:00 PM",
    department: "Management",
    date: "12 Mar 2026",
  ),

  // EMP005 - David Wilson (Doctor - Neurology)
  EmployeeShift(
    employeeId: "EMP005",
    shiftType: "Morning",
    startTime: "08:00 AM",
    endTime: "04:00 PM",
    department: "Neurology",
    date: "13 Mar 2026",
  ),

  // EMP006 - Olivia Martinez (Nurse - Pediatrics)
  EmployeeShift(
    employeeId: "EMP006",
    shiftType: "Evening",
    startTime: "02:00 PM",
    endTime: "10:00 PM",
    department: "Pediatrics",
    date: "13 Mar 2026",
  ),
  
  // EMP007 - James Anderson (Technician - Laboratory)
  EmployeeShift(
    employeeId: "EMP007",
    shiftType: "Morning",
    startTime: "07:00 AM",
    endTime: "03:00 PM",
    department: "Laboratory",
    date: "12 Mar 2026",
  ),

  // EMP009 - Daniel Thomas (Doctor - Dermatology)
  EmployeeShift(
    employeeId: "EMP009",
    shiftType: "Morning",
    startTime: "10:00 AM",
    endTime: "06:00 PM",
    department: "Dermatology",
    date: "14 Mar 2026",
  ),

  // EMP010 - Ava White (Pharmacist - Pharmacy)
  EmployeeShift(
    employeeId: "EMP010",
    shiftType: "Night",
    startTime: "10:00 PM",
    endTime: "06:00 AM",
    department: "Pharmacy",
    date: "12 Mar 2026",
  ),
];