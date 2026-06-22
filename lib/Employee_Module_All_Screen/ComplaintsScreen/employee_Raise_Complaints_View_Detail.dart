import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/Employee_Module_All_Screen/ComplaintsScreen/employee_Edit_Complaints_Page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EmployeeRaiseComplaintsViewDetail extends StatefulWidget {
  final String id;
  final String Date;
  final String Department;
  final String Description;
  final String Uploaded_Image_Name;
  final String Uploaded_Image_Size;
  final String Remarks;
  final String status;
  const EmployeeRaiseComplaintsViewDetail({
    super.key,
    required this.id,
    required this.Date,
    required this.Department,
    required this.Description,
    required this.Uploaded_Image_Name,
    required this.Uploaded_Image_Size,
    required this.Remarks,
    required this.status,
  });

  @override
  State<EmployeeRaiseComplaintsViewDetail> createState() =>
      _EmployeeRaiseComplaintsViewDetailState();
}

class _EmployeeRaiseComplaintsViewDetailState
    extends State<EmployeeRaiseComplaintsViewDetail> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload Image",
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xff64748B),
          ),
        ),

        const SizedBox(height: 12),

        selectedImage == null
            ? InkWell(
                onTap: showImagePicker,
                child: Container(
                  // height: 194,
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffCBD5E1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/Upload.png",
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 325,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "Drag & drop area to upload PDF, JPG, JPEG, PNG",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1F2937),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Maximum File Size is 1 MB",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff644EE5),
                          border: Border.all(color: const Color(0xff644EE5)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/Upload (1).png", // apni image
                              width: 20,
                              height: 20,
                            ),

                            const SizedBox(width: 8),

                            Text(
                              "Choose File",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffF8FAFC),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        selectedImage!,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedImage!.path.split('/').last,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff1E293B),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "Image Selected",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xff64748B),
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: showImagePicker,
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Align(
          alignment: AlignmentGeometry.centerStart,
          child: Text(
            "Complaints",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        toolbarHeight: 60,
        shape: const Border(
          bottom: BorderSide(color: Color(0xffE2E8F0), width: 1),
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildField("Complaint ID", widget.id, widget.status),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              _buildField("Date", widget.Date, ""),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              _buildField("Department", widget.Department, ""),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              _buildField("Description", widget.Description, ""),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              widget.status.trim().toLowerCase() == 'pending'
                  ? buildImageSection()
                  : Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Uploaded Image",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff71717A),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xffF1F5F9,
                              ), // Background color
                              border: Border.all(
                                color: const Color(0xffF1F5F9), // Border color
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/Frame 2147235640.png",
                                  width: 56,
                                  height: 56,
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.Uploaded_Image_Name}",
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff1F2937),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Align(
                                      alignment: AlignmentGeometry.centerStart,
                                      child: Text(
                                        "${widget.Uploaded_Image_Size}",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff6B7280),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

              widget.status.trim().toLowerCase() == "pending"
                  ? Container()
                  : Container(
                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                          _buildField(
                            "Remarks (From Admin)",
                            widget.Remarks,
                            "",
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: widget.status.trim().toLowerCase() == "pending"
          ? Padding(
              padding: const EdgeInsets.all(16),

              child: SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // ! header
                                      Row(
                                        children: [
                                          Text(
                                            "Delete Complaint",
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
                                      SizedBox(height: 32),
                                      Text(
                                        "Are you sure you want to delete this complaint?",
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff1E293B),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "This action cannot be undone",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff64748B),
                                        ),
                                      ),

                                      SizedBox(height: 16),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 16,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 48,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xffEDE9FE),
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Cancel",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff644EE5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 12),
                                            Expanded(
                                              child: SizedBox(
                                                height: 48,
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xffDC2626),
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Yes, Delete",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xffFEE2E2),
                            side: const BorderSide(color: Color(0xffFEE2E2)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Delete",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffDC2626),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeEditComplaintsPage(
                                      Description: widget.Description,
                                      FileName: widget.Uploaded_Image_Name,
                                      Size: widget.Uploaded_Image_Size,
                                    ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff644EE5),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Edit",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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
}

Widget _buildField(String title, String value, String status) {
  Color bgColor;
  Color textColor;

  switch (status.toLowerCase()) {
    case "resolved":
      bgColor = const Color(0xffDCFCE7);
      textColor = const Color(0xff16A34A);
      break;

    case "pending":
      bgColor = Color(0xffFEF9C3);
      textColor = Color(0xffCA8A04);
      break;

    case "rejected":
      bgColor = const Color(0xffFEE2E2);
      textColor = const Color(0xffDC2626);
      break;

    default:
      bgColor = Colors.white;
      textColor = Colors.white;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Align(
        alignment: AlignmentGeometry.centerStart,
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xff64748B),
          ),
        ),
      ),

      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff1E293B),
              ),
            ),
          ),

          if (status.isNotEmpty) ...[
            const SizedBox(width: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
          ],
        ],
      ),
    ],
  );
}
