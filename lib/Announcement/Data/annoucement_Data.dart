class AnnouncementModel {
  final String title;
  final String startDate;
  final String endDate;
  final String status;
  final String monthCategory;

  AnnouncementModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.monthCategory,
  });
}

final List<AnnouncementModel> announcementData = [
  // This Month
  AnnouncementModel(
    title: "Announcement for Diwali holiday",
    startDate: "12 Mar 2026",
    endDate: "13 Mar 2026",
    status: "Active",
    monthCategory: "This Month",
  ),

  AnnouncementModel(
    title: "Reminder for Team Meeting",
    startDate: "15 Mar 2026",
    endDate: "15 Mar 2026",
    status: "Active",
    monthCategory: "This Month",
  ),

  // Last Month
  AnnouncementModel(
    title: "Announcement for Diwali holiday",
    startDate: "12 Feb 2026",
    endDate: "13 Feb 2026",
    status: "Inactive",
    monthCategory: "Last Month",
  ),

  AnnouncementModel(
    title: "Reminder for Team Meeting",
    startDate: "15 Feb 2026",
    endDate: "15 Feb 2026",
    status: "Active",
    monthCategory: "Last Month",
  ),

  AnnouncementModel(
    title: "Feedback Request for Product Launch",
    startDate: "20 Feb 2026",
    endDate: "20 Feb 2026",
    status: "Active",
    monthCategory: "Last Month",
  ),

  AnnouncementModel(
    title: "Office Maintenance Notice",
    startDate: "22 Feb 2026",
    endDate: "22 Feb 2026",
    status: "Inactive",
    monthCategory: "Last Month",
  ),

  AnnouncementModel(
    title: "Annual Performance Review Reminder",
    startDate: "25 Feb 2026",
    endDate: "28 Feb 2026",
    status: "Active",
    monthCategory: "Last Month",
  ),

  AnnouncementModel(
    title: "Company Sports Day Announcement",
    startDate: "05 Feb 2026",
    endDate: "05 Feb 2026",
    status: "Active",
    monthCategory: "Last Month",
  ),
];