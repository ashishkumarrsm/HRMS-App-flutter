class ComplaintModel {
  final String id;
  final String status;
  final String date;
  final String department;
  final String description;
  final String image;
  final String imageName;
  final String imageSize;
  final String remarks;

  ComplaintModel({
    required this.id,
    required this.status,
    required this.date,
    required this.department,
    required this.description,
    required this.image,
    required this.imageName,
    required this.imageSize,
    required this.remarks,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      date: json['date'] ?? '',
      department: json['department'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      imageName: json['imageName'] ?? '',
      imageSize: json['imageSize'] ?? '',
      remarks: json['remarks'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'date': date,
      'department': department,
      'description': description,
      'image': image,
      'imageName': imageName,
      'imageSize': imageSize,
      'remarks': remarks,
    };
  }
}

final List<Map<String, dynamic>> complaintData = [
  // ================= PENDING =================
  // {
  //   "id": "CMP1231",
  //   "status": "Pending",
  //   "date": "10 Aug 2025",
  //   "department": "Hostel Management",
  //   "description":
  //       "The fan in my hostel room is not working properly. It makes a loud noise and stops frequently during the night.",
  //   "image": "assets/images/complaint1.jpg",
  //   "imageName": "fan_issue.jpg",
  //   "imageSize": "1.5 MB",
  //   "remarks": "",
  // },

  // {
  //   "id": "CMP1232",
  //   "status": "Pending",
  //   "date": "11 Aug 2025",
  //   "department": "Maintenance",
  //   "description":
  //       "The washroom tap is leaking continuously and water is being wasted. Kindly fix it as soon as possible.",
  //   "image": "assets/images/complaint2.jpg",
  //   "imageName": "tap_leak.jpg",
  //   "imageSize": "2 MB",
  //   "remarks": "",
  // },

  // ================= RESOLVED =================
  {
    "id": "CMP1233",
    "status": "Resolved",
    "date": "05 Aug 2025",
    "department": "Electrical",
    "description":
        "The tube light in my room was flickering and not providing proper lighting for study.",
    "image": "assets/images/complaint3.jpg",
    "imageName": "tube_light.jpg",
    "imageSize": "1.2 MB",
    "remarks":
        "Issue has been resolved. Electrical team replaced the faulty tube light.",
  },

  {
    "id": "CMP1234",
    "status": "Resolved",
    "date": "07 Aug 2025",
    "department": "Gastroenterology",
    "description":
        "I want to report a water leakage issue in my hostel room. The leak is coming from the ceiling near the window and it has been getting worse over the past few days.",
    "image": "assets/images/complaint4.jpg",
    "imageName": "14563456775.jpg",
    "imageSize": "2 MB",
    "remarks":
        "Maintenance team fixed the leakage and completed the repair work.",
  },

  // ================= REJECTED =================
  {
    "id": "CMP1235",
    "status": "Rejected",
    "date": "03 Aug 2025",
    "department": "Transport",
    "description":
        "I requested a personal vehicle parking slot near the main entrance.",
    "image": "assets/images/complaint5.jpg",
    "imageName": "parking_request.jpg",
    "imageSize": "1 MB",
    "remarks":
        "Request rejected because parking allocation is not handled through complaint management.",
  },

  {
    "id": "CMP1236",
    "status": "Rejected",
    "date": "02 Aug 2025",
    "department": "Administration",
    "description":
        "Requested a room change without providing any valid reason or supporting documents.",
    "image": "assets/images/complaint6.jpg",
    "imageName": "room_change.jpg",
    "imageSize": "1.8 MB",
    "remarks": "Request rejected due to insufficient justification.",
  },
];
