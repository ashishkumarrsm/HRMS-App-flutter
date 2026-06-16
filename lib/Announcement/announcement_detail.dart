import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Announcement/announcement_Home_Screen.dart';
import 'package:image_picker/image_picker.dart';

class AnnouncementDetail extends StatefulWidget {
  final AnnouncementModel item;

  const AnnouncementDetail({super.key, required this.item});

  @override
  State<AnnouncementDetail> createState() => _AnnouncementDetailState();
}

class _AnnouncementDetailState extends State<AnnouncementDetail> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () async {
                  Navigator.pop(context);

                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (image != null) {
                    setState(() {
                      selectedImage = File(image.path);
                    });
                  }
                },
              ),

              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () async {
                  Navigator.pop(context);

                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                  );

                  if (image != null) {
                    setState(() {
                      selectedImage = File(image.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        shape: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
        title: Text(
          "Announcement Details",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subject
              _buildLabel("Subject"),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.item.title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Active",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF16A34A),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Divider(color: Color(0xFFE2E8F0)),

              // Start Date
              const SizedBox(height: 16),
              _buildLabel("Start Date"),

              Text(
                "12 Mar 2026",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 16),
              const Divider(color: Color(0xFFE2E8F0)),

              // End Date
              const SizedBox(height: 16),
              _buildLabel("End Date"),

              Text(
                "13 Mar 2026",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 16),
              const Divider(color: Color(0xFFE2E8F0)),

              // Message
              const SizedBox(height: 16),
              _buildLabel("Message"),

              Text(
                widget.item.description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.7,
                  color: const Color(0xFF334155),
                ),
              ),

              const SizedBox(height: 16),
              const Divider(color: Color(0xFFE2E8F0)),

              // Media
              const SizedBox(height: 16),
              _buildLabel("Media"),

              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: selectedImage != null
                            ? Image.file(
                                selectedImage!,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 56,
                                height: 56,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.white,
                                ),
                              ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedImage != null
                                  ? selectedImage!.path.split('/').last
                                  : "Tap to select image",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E293B),
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              selectedImage != null
                                  ? "Image Selected"
                                  : "Camera or Gallery",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Color(0xFFE2E8F0)),

              // Announce By
              const SizedBox(height: 16),
              _buildLabel("Announce BY"),

              Text(
                "Mohan Singh (HOD)",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 30),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: // Buttons
        Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Delete Announcement?",
                                      style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Image.asset(
                                        "assets/images/Close Icon.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),
                                const SizedBox(height: 16),

                                Align(
                                  alignment: AlignmentGeometry.centerLeft,
                                  child: Text(
                                    "Are you sure you want to delete this announcement? This action cannot be undone.",
                                    // textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      // color: const Color(0xFF64748B),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),
                                Align(
                                  alignment: AlignmentGeometry.centerLeft,
                                  child: Text(
                                    "This action cannot be undone",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 52,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                              color: Color(0xFFEDE9FE),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            backgroundColor: Color(0xFFEDE9FE),
                                          ),
                                          child: Text(
                                            "Cancel",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF644EE5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: SizedBox(
                                        height: 52,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                              color: Color(0xFFDC2626),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            backgroundColor: Color(0xFFDC2626),
                                          ),
                                          child: Text(
                                            "Yes, Delete",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFFFEE2E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Delete",
                      style: GoogleFonts.inter(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF644EE5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Edit",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF71717A),
        ),
      ),
    );
  }
}
