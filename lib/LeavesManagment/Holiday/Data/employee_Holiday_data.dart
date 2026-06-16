class HolidayModel {
  final String title;
  final String category;
  final String startDate;
  final String description;

  HolidayModel({
    required this.title,
    required this.category,
    required this.startDate,
    required this.description,
  });
}

final List<HolidayModel> holidayData = [
  HolidayModel(
    title: "Republic Day",
    category: "National Holiday",
    startDate: "26 Jan 2026",
    description:
        "India's Republic Day commemorates the adoption of its Constitution, showcasing national pride and unity.",
  ),

  HolidayModel(
    title: "Holi",
    category: "Festival Holiday",
    startDate: "8 Mar 2026",
    description:
        "Festival of colors, celebrating the arrival of spring.",
  ),

  HolidayModel(
    title: "Raksha Bandhan",
    category: "Festival Holiday",
    startDate: "12 Mar 2026",
    description:
        "A celebration of sibling bonds.",
  ),

  HolidayModel(
    title: "Diwali",
    category: "Festival Holiday",
    startDate: "14 Nov 2026",
    description:
        "Festival of lights, symbolizing the victory of light over darkness.",
  ),

  HolidayModel(
    title: "Goverdhan Puja",
    category: "Festival Holiday",
    startDate: "15 Nov 2026",
    description:
        "Festival of lights, symbolizing the victory of light over darkness.",
  ),

  HolidayModel(
    title: "Independence Day",
    category: "National Holiday",
    startDate: "15 Aug 2026",
    description:
        "India's Independence Day celebrates the nation's freedom from British rule, symbolizing sovereignty and resilience.",
  ),

  HolidayModel(
    title: "Gandhi Jayanti",
    category: "National Holiday",
    startDate: "02 Oct 2026",
    description:
        "Honoring Mahatma Gandhi's legacy of peace, truth, and non-violence.",
  ),

  HolidayModel(
    title: "Christmas",
    category: "Festival Holiday",
    startDate: "25 Dec 2026",
    description:
        "Celebration of the birth of Jesus Christ, marked by joy and togetherness.",
  ),

  HolidayModel(
    title: "Makar Sankranti",
    category: "Festival Holiday",
    startDate: "14 Jan 2026",
    description:
        "Harvest festival celebrated across India with kite flying and traditional foods.",
  ),

  HolidayModel(
    title: "Labour Day",
    category: "National Holiday",
    startDate: "01 May 2026",
    description:
        "A day dedicated to honoring workers and their contributions to society.",
  ),
];