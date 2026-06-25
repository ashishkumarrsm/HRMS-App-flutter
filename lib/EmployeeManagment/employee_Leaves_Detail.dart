import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hrms/EmployeeManagment/Data/employee_Requeted_Approved_Rejected_Data.dart';

class EmployeeLeavesDetail extends StatefulWidget {
  final LeaveHistoryRecord record;
  const EmployeeLeavesDetail({super.key, required this.record});

  @override
  State<EmployeeLeavesDetail> createState() => _EmployeeLeavesDetailState();
}

class _EmployeeLeavesDetailState extends State<EmployeeLeavesDetail> {
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
        title: Align(
          alignment: AlignmentGeometry.centerStart,
          child: Text(
            "Leave Details",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
      ),

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailField(
                "Employee",
                widget.record.employeeName,
                widget.record.status,
              ),
              _buildDetailField("Leave Type", widget.record.leaveType, ""),
              _buildDetailField(
                "Leave Category",
                widget.record.leaveCategory,
                "",
              ),
              _buildDetailField("Start Date", widget.record.startDate, ""),
              _buildDetailField("End Date", widget.record.endDate, ""),
              _buildDetailField(
                "Requested Days",
                widget.record.requestedDays,
                "",
              ),
              _buildDetailField("Available", widget.record.available, ""),
              _buildDetailField("Applied On", widget.record.appliedOn, ""),
              _buildDetailField("Status", widget.record.status, ""),
              _buildDetailField("Leave Reason", widget.record.reason, ""),

              const SizedBox(height: 20),

              // ================= ATTACHMENT SECTION =================
              Text(
                "Document Attached",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),

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

              const SizedBox(height: 30),
              // Divider(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xffE2E8F0), width: 1)),
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
                        return GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: AnimatedPadding(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: SingleChildScrollView(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Reject Leave Request",
                                          style: GoogleFonts.inter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff334155),
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

                                    SizedBox(height: 12),
                                    Divider(),
                                    SizedBox(height: 20),
                                    Column(
                                      children: [
                                        Text(
                                          "Are you sure you want to reject this leave request",
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
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
                                              fontWeight: FontWeight.w600,
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
                                    SizedBox(height: 20),
                                    Divider(),
                                    SizedBox(height: 24),
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFFFEE2E2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFFFEE2E2), width: 1),

                    // ✅ RADIUS
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: Text(
                    "Reject",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFDC2626),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF644EE5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFF644EE5), width: 1),

                    // ✅ RADIUS
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: Text(
                    "Approve",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

  Widget _buildDetailField(String label, String value, String status) {
    bool isStatus = label.toLowerCase() == "employee";

    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case "approved":
        bgColor = const Color(0xffDCFCE7);
        textColor = const Color(0xff16A34A);
        break;

      case "pending":
      case "requested":
        bgColor = const Color(0xffFEF9C3);
        textColor = const Color(0xffCA8A04);
        break;

      case "rejected":
        bgColor = const Color(0xffFEE2E2);
        textColor = const Color(0xffDC2626);
        break;

      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.grey.shade700;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xff71717A),
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 12),

          isStatus
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff1E283B),
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        status, // Approved / Pending / Rejected
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                )
              : Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff1E283B),
                  ),
                ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade200),
        ],
      ),
    );
  }
}
