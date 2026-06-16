import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Announcement/add_Announcement.dart';
import 'package:hrms/Announcement/announcement_detail.dart';

class AnnouncementModel {
  final String title;
  final String startDate;
  final String endDate;
  final String status;
  final String monthCategory;
  final String description;

  AnnouncementModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.monthCategory,
    required this.description,
  });
}

final List<AnnouncementModel> announcementData = [
  AnnouncementModel(
    title: "Announcement for Diwali holiday",
    startDate: "12 Mar 2026",
    endDate: "13 Mar 2026",
    status: "Active",
    monthCategory: "This Month",
    description:
        "🎉 Exciting News! 🎉\n\nWe are thrilled to announce that in celebration of Diwali, our office will remain closed on November 12th. This is a wonderful opportunity for everyone to enjoy the festivities with family and friends.\n\nWishing you all a joyful and prosperous Diwali! 🪔✨",
  ),

  AnnouncementModel(
    title: "Reminder for Team Meeting",
    startDate: "15 Mar 2026",
    endDate: "15 Mar 2026",
    status: "Active",
    monthCategory: "This Month",
    description:
        "Dear Team,\n\nThis is a friendly reminder that our monthly team meeting is scheduled for tomorrow at 10:00 AM in the conference room. Please ensure your reports are updated and be prepared to discuss project progress.\n\nThank you.",
  ),

  AnnouncementModel(
    title: "Announcement for Diwali holiday",
    startDate: "12 Feb 2026",
    endDate: "13 Feb 2026",
    status: "Inactive",
    monthCategory: "Last Month",
    description:
        "The Diwali holiday announcement has now expired. Employees are requested to follow the regular office schedule and attendance policy.\n\nFor any queries, please contact the HR department.",
  ),

  AnnouncementModel(
    title: "Reminder for Team Meeting",
    startDate: "15 Feb 2026",
    endDate: "15 Feb 2026",
    status: "Active",
    monthCategory: "Last Month",
    description:
        "All team members are requested to attend the scheduled meeting. Important updates regarding upcoming projects, deadlines, and departmental goals will be shared during the session.",
  ),

  AnnouncementModel(
    title: "Feedback Request for Product Launch",
    startDate: "20 Feb 2026",
    endDate: "20 Feb 2026",
    status: "Active",
    monthCategory: "Last Month",
    description:
        "We recently launched our new product and would love to hear your feedback. Please take a few minutes to share your experience, suggestions, and observations.\n\nYour feedback helps us improve and deliver a better experience for everyone.",
  ),
];

class AnnouncementHomeScreen extends StatefulWidget {
  const AnnouncementHomeScreen({super.key});

  @override
  State<AnnouncementHomeScreen> createState() => _AnnouncementHomeScreenState();
}

class _AnnouncementHomeScreenState extends State<AnnouncementHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final thisMonthAnnouncements = announcementData
        .where((e) => e.monthCategory == "This Month")
        .toList();

    final lastMonthAnnouncements = announcementData
        .where((e) => e.monthCategory == "Last Month")
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Announcement",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 60,
        shape: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  "Announcement",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAnnouncement(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.white, size: 18),
                  label: const Text(
                    "Add Announcement",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF644EE5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              children: [
                Text(
                  "This month's announcement",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 16),

                ...thisMonthAnnouncements.map(
                  (item) => _buildAnnouncementCard(item),
                ),

                const SizedBox(height: 24),

                Text(
                  "Last Month's announcement",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 16),

                ...lastMonthAnnouncements.map(
                  (item) => _buildAnnouncementCard(item),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(AnnouncementModel item) {
    final bool isActive = item.status == "Active";

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnnouncementDetail(item: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.campaign_outlined,
                  color: Color(0xFF64748B),
                  size: 20,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    item.title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFDCFCE7)
                        : const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.status,
                    style: GoogleFonts.inter(
                      color: isActive
                          ? const Color(0xFF16A34A)
                          : const Color(0xFFDC2626),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Divider(color: Colors.grey.shade200, height: 1),

            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Color(0xFF64748B),
                ),

                const SizedBox(width: 12),

                Text(
                  "${item.startDate} to ${item.endDate}",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
