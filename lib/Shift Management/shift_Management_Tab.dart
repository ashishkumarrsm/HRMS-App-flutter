import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Shift%20Management/shift_Edit.dart';

class ShiftManagementTab extends StatefulWidget {
  const ShiftManagementTab({super.key});

  @override
  State<ShiftManagementTab> createState() => _ShiftManagementTabState();
}

class _ShiftManagementTabState extends State<ShiftManagementTab> {
  final List<Map<String, String>> morningShiftData = List.generate(
    6,
    (index) => {
      "name": "Dr. Sarah Johnson",
      "id": "ID1234",
      "gender": "MALE",
      "shiftType": "Morning",
      "time": "08:00 AM - 04:00 PM",
      "department": "Cardiology",
    },
  );

  final List<Map<String, String>> eveningShiftData = List.generate(
    6,
    (index) => {
      "name": "Dr. Michael Smith",
      "id": "ID5678",
      "gender": "MALE",
      "shiftType": "Evening",
      "time": "04:00 PM - 12:00 AM",
      "department": "Neurology",
    },
  );

  final List<Map<String, String>> nightShiftData = List.generate(
    6,
    (index) => {
      "name": "Dr. Emily Brown",
      "id": "ID9876",
      "gender": "FEMALE",
      "shiftType": "Night",
      "time": "12:00 AM - 08:00 AM",
      "department": "Emergency",
    },
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: const Color(0xFF644EE5),
            unselectedLabelColor: const Color(0xFF64748B),
            dividerColor: const Color(0xFFE2E8F0),
            indicatorColor: const Color(0xFF644EE5),
            labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: "Morning Shift"),
              Tab(text: "Evening Shift"),
              Tab(text: "Night Shift"),
            ],
          ),

          Expanded(
            child: TabBarView(
              children: [
                _buildShiftList(morningShiftData),
                _buildShiftList(eveningShiftData),
                _buildShiftList(nightShiftData),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftList(List<Map<String, String>> shifts) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: shifts.length,
      itemBuilder: (context, index) {
        final shift = shifts[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/Doctor.png",
                    width: 20,
                    height: 20,
                  ),

                  SizedBox(width: 8),

                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: shift["name"],
                            style: GoogleFonts.inter(
                              color: const Color(0xFF1E293B),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: " · ${shift["id"]} · ${shift["gender"]}",
                            style: GoogleFonts.inter(
                              color: const Color(0xFF64748B),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Spacer(),
                  SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {
                        print(shift["name"]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShiftEdit(shiftData: shift),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF644EE5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Edit Shift",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Divider(color: Color(0xFFE2E8F0)),
              const SizedBox(height: 12),

              Row(
                children: [
                  _label("Shift Type"),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE9FE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      shift["shiftType"]!,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF644EE5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  _label("Time"),
                  Expanded(
                    child: Text(
                      shift["time"]!,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  _label("Department"),
                  Expanded(
                    child: Text(
                      shift["department"]!,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _label(String text) {
    return SizedBox(
      width: 110,
      child: Text(
        text,
        style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 14),
      ),
    );
  }
}
