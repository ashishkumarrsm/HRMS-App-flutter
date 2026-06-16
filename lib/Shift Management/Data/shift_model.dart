class ShiftModel {
  final String name;
  final String id;
  final String gender;
  final String shiftType;
  final String time;
  final String department;

  ShiftModel({
    required this.name,
    required this.id,
    required this.gender,
    required this.shiftType,
    required this.time,
    required this.department,
  });
}




final List<ShiftModel> morningShiftData = List.generate(
  6,
  (index) => ShiftModel(
    name: "Dr. Sarah Johnson",
    id: "ID1234",
    gender: "MALE",
    shiftType: "Morning",
    time: "08:00 AM - 04:00 PM",
    department: "Cardiology",
  ),
);

final List<ShiftModel> eveningShiftData = List.generate(
  6,
  (index) => ShiftModel(
    name: "Dr. Michael Smith",
    id: "ID5678",
    gender: "MALE",
    shiftType: "Evening",
    time: "04:00 PM - 12:00 AM",
    department: "Neurology",
  ),
);

final List<ShiftModel> nightShiftData = List.generate(
  6,
  (index) => ShiftModel(
    name: "Dr. Emily Brown",
    id: "ID9876",
    gender: "FEMALE",
    shiftType: "Night",
    time: "12:00 AM - 08:00 AM",
    department: "Emergency",
  ),
);