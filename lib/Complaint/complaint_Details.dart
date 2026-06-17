import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Data/complaint_Data.dart';
import 'package:image_picker/image_picker.dart';

class ComplaintDetails extends StatefulWidget {
  final ComplaintRecord complaint;

  const ComplaintDetails({super.key, required this.complaint});

  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails>
    with SingleTickerProviderStateMixin {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ✅ FILE SIZE FUNCTION
  String _getFileSize(File file) {
    final bytes = file.lengthSync();

    if (bytes < 1024) return "$bytes B";
    if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(1)} KB";
    return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
  }

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color pillBgColor;
    Color pillTextColor;

    switch (widget.complaint.status) {
      case "Approved":
        pillBgColor = const Color(0xFFDCFCE7);
        pillTextColor = const Color(0xFF16A34A);
        break;

      case "Rejected":
        pillBgColor = const Color(0xFFFEE2E2);
        pillTextColor = const Color(0xFFDC2626);
        break;

      default:
        pillBgColor = const Color(0xFFFEF9C3);
        pillTextColor = const Color(0xFFCA8A04);
    }

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Align(
          alignment: AlignmentGeometry.centerStart,
          child: Text(
            "Complaint Details",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        toolbarHeight: 60,
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Complaint ID",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF71717A),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${widget.complaint.complaintId} ",
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
                    color: pillBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.complaint.status,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: pillTextColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Divider(color: Colors.grey.shade200),

            const SizedBox(height: 16),

            _buildInfoTile("Complaint Date", widget.complaint.complaintDate),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile(
              "Complaint by",
              widget.complaint.employeeName,
              // valueColor: const Color(0xFFDC2626),
            ),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile(
              "Position",
              widget.complaint.position,
              // valueColor: const Color(0xFF16A34A),
            ),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile("Department", widget.complaint.department),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile("Mobile Number", widget.complaint.complaintDate),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildInfoTile("Discription", widget.complaint.description),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),

            // _buildInfoTile("Description", widget.complaint.description),
            // Divider(color: Colors.grey.shade200),
            if (widget.complaint.status == "Pending") ...[
              GestureDetector(
                onTap: _showOptions,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: _image != null
                      ? Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _image!,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _image!.path.split('/').last,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _getFileSize(_image!),
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const Icon(
                                Icons.add_a_photo,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Tap to upload file",
                              style: GoogleFonts.inter(color: Colors.grey),
                            ),
                          ],
                        ),
                ),
              ),
            ] else if (widget.complaint.status == "Rejected") ...[
              const SizedBox(height: 20),

              _buildInfoTile(
                "Rejected By",
                "John Manager",
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: Color(0xFFFEF2F2),
                    border: Border.all(
                      color: const Color(0xFFFECACA),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(
                          "Rejection Reason",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ),

                      SizedBox(height: 8),
                      Text(
                        "The overtime hours submitted do not align with project timelines and budget constraints. Please prioritize tasks within regular working hours.",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar:
          widget.complaint.status.trim().toLowerCase() == "pending"
          ? SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentGeometry.centerStart,

                                          child: Text(
                                            "Reject Complaint Request",
                                            style: GoogleFonts.inter(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Image.asset(
                                            "assets/images/Close Icon.png",
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 8),
                                    Divider(),
                                    SizedBox(height: 16),
                                    Column(
                                      children: [
                                        Text(
                                          "Are you sure you want to reject this leave request",
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Align(
                                          alignment:
                                              AlignmentGeometry.centerStart,
                                          child: Text(
                                            "This action cannot be undone",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF64748B),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 24),
                                    Column(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentGeometry.centerLeft,

                                          child: Text(
                                            "Remark",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextField(
                                          minLines: 5,
                                          maxLines: 8,
                                          decoration: InputDecoration(
                                            hintText: "Enter remark",
                                            hintStyle: const TextStyle(
                                              color: Color(0xFF64748B),
                                              fontSize: 14,
                                              height: 1.5,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,

                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 14,
                                                ),

                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                color: Color(0xFFE2E8F0),
                                              ),
                                            ),

                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                color: Color(0xFFE2E8F0),
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Divider(),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0, // shadow remove
                                              backgroundColor: const Color(
                                                0xFFEDE9FE,
                                              ), // background color
                                              foregroundColor: const Color(
                                                0xFF644EE5,
                                              ), // text color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      12,
                                                    ), // radius
                                                side: BorderSide
                                                    .none, // border remove
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                  ),
                                            ),
                                            child: const Text("Cancel"),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0, // shadow remove
                                              backgroundColor: const Color(
                                                0xFFDC2626,
                                              ), // background color

                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      12,
                                                    ), // radius
                                                side: BorderSide
                                                    .none, // border remove
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                  ),
                                            ),
                                            child: const Text(
                                              "Yes, Reject",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: const Color(0xFFFEE2E2),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Reject",
                          style: GoogleFonts.inter(
                            color: const Color(0xFFDC2626),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentGeometry.centerStart,

                                          child: Text(
                                            "Add Complaint Remarks",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Image.asset(
                                            "assets/images/Close Icon.png",
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    SizedBox(height: 24),
                                    Column(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentGeometry.centerLeft,

                                          child: Text(
                                            "Remark",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextField(
                                          minLines: 5,
                                          maxLines: 8,
                                          decoration: InputDecoration(
                                            hintText: "Enter employee name",
                                            hintStyle: const TextStyle(
                                              color: Color(0xFF64748B),
                                              fontSize: 14,
                                              height: 1.5,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,

                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 14,
                                                ),

                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                color: Color(0xFFE2E8F0),
                                              ),
                                            ),

                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                color: Color(0xFFE2E8F0),
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 24),
                                    Divider(),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0, // shadow remove
                                              backgroundColor: const Color(
                                                0xFFEDE9FE,
                                              ), // background color
                                              foregroundColor: const Color(
                                                0xFF644EE5,
                                              ), // text color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      12,
                                                    ), // radius
                                                side: BorderSide
                                                    .none, // border remove
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                  ),
                                            ),
                                            child: const Text("Cancel"),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0, // shadow remove
                                              backgroundColor: const Color(
                                                0xFF644EE5,
                                              ), // background color

                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      12,
                                                    ), // radius
                                                side: BorderSide
                                                    .none, // border remove
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                  ),
                                            ),
                                            child: const Text(
                                              "Submit",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: const Color(0xFF644EE5),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Approve",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildInfoTile(
    String title,
    String value, {
    Color valueColor = Colors.black,
    Widget? child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF71717A),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: valueColor,
            ),
          ),
          if (child != null) ...[const SizedBox(height: 8), child],
        ],
      ),
    );
  }
}
