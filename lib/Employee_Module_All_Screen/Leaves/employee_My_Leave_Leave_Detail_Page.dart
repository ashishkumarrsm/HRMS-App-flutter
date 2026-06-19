import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeMyLeaveLeaveDetailPage extends StatefulWidget {
  final String leaveType;
  final String leaveCategory;
  final String startDate;
  final String endDate;
  final int requestedDays;
  final String availableLeave;
  final String appliedOn;
  final String leaveReason;
  final String documentName;
  final String documentSize;
  final String approvedBy;
  final String status;

  const EmployeeMyLeaveLeaveDetailPage({
    super.key,
    required this.leaveType,
    required this.leaveCategory,
    required this.startDate,
    required this.endDate,
    required this.requestedDays,
    required this.availableLeave,
    required this.appliedOn,
    required this.leaveReason,
    required this.documentName,
    required this.documentSize,
    required this.approvedBy,
    required this.status,
  });

  @override
  State<EmployeeMyLeaveLeaveDetailPage> createState() =>
      _EmployeeMyLeaveLeaveDetailPageState();
}

class _EmployeeMyLeaveLeaveDetailPageState
    extends State<EmployeeMyLeaveLeaveDetailPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        // shadowColor: Colors.white,
        toolbarHeight: 60,
        shape: const Border(bottom: BorderSide(color: Color(0xffE2E8F0))),

        title: Align(
          alignment: AlignmentGeometry.centerStart,
          child: Text(
            "Leave Details",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // *====== Leave Type===
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Leave Type",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff71717A),
                      ),
                    ),
                    SizedBox(height: 12),

                    Row(
                      children: [
                        Text(
                          widget.leaveType,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: widget.status == "Approved"
                                ? const Color(0xffDCFCE7)
                                : widget.status == "Pending"
                                ? const Color(0xffFEF3C7)
                                : const Color(0xffFEE2E2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.status,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: widget.status == "Approved"
                                  ? const Color(0xff16A34A)
                                  : widget.status == "Pending"
                                  ? const Color(0xffD97706)
                                  : const Color(0xffDC2626),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              ),

              // *====== Leave Category===
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerStart,
                      child: Text(
                        "Leave Category",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff71717A),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      widget.leaveCategory,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              ),

              // *====== Leave Category===
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerStart,
                      child: Text(
                        "Start Date",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff71717A),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      widget.startDate,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              ),

              // *====== Leave Category===
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerStart,
                      child: Text(
                        "End Date",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff71717A),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      widget.endDate,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              ),

              // *====== Leave Category===
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerStart,
                      child: Text(
                        "Requested Days",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff71717A),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      "${widget.requestedDays}",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              ),

              // *====== Leave Category===
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerStart,
                      child: Text(
                        "Available Leave",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff71717A),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      widget.availableLeave,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              ),

              // *====== Leave Category===
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerStart,
                      child: Text(
                        "Applied On",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff71717A),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      widget.appliedOn,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              ),

              // *====== Leave Category===
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerStart,
                      child: Text(
                        "leave Reason",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff71717A),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      widget.leaveReason,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              ),

              // *====== Image section ===
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerStart,
                      child: Text(
                        "Document Attached",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff71717A),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffF8FAFC),
                        border: Border.all(
                          color: const Color(0xffE2E8F0),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: widget.status.toLowerCase().trim() == "approved"
                          ? GestureDetector(
                              onTap: _showOptions,
                              child: Container(
                                child: _image != null
                                    ? Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _image!.path.split('/').last,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.add_a_photo,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            "Tap to upload file",
                                            style: GoogleFonts.inter(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            )
                          : Row(
                              children: [
                                Image.asset(
                                  "assets/images/Frame 2147235640.png",
                                  width: 56,
                                  height: 56,
                                ),
                                SizedBox(width: 16),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.documentName,
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff1F2937),
                                      ),
                                    ),

                                    SizedBox(height: 4),
                                    Text(
                                      widget.documentSize,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),

                    widget.status.trim().toLowerCase() == "pending"
                        ? SizedBox(height: 120)
                        : Container(),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Divider(),
              // ),
              widget.status.toLowerCase().trim() == "approved"
                  ? Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(),
                          ),
                          // *====== Leave Category===
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentGeometry.centerStart,
                                  child: Text(
                                    "Approved By",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff71717A),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),

                                Text(
                                  widget.approvedBy,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 16),
                          //   child: Divider(),
                          // ),
                          SizedBox(height: 120),
                        ],
                      ),
                    )
                  : widget.status.trim().toLowerCase() == "rejected"
                  ? Container(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Divider(),
                              ),
                              // *====== Leave Category===
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: AlignmentGeometry.centerStart,
                                      child: Text(
                                        "Rejected By",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff71717A),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12),

                                    Text(
                                      widget.approvedBy,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Divider(),
                              ),
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.all(16),
                            // padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xffFEF2F2,
                              ), // Background Color

                              border: Border.all(
                                color: const Color(0xffFECACA), // Border Color
                                width: 1,
                              ),

                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: AlignmentGeometry.centerStart,
                                    child: Text(
                                      "Rejection Reason",
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    widget.leaveReason,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff1F2937),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 120),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
