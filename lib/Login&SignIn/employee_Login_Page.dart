import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms/EmployeeManagment/employee_Home_Screen.dart';
import 'package:hrms/Service/biomatricAuthService.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/src/local_auth.dart';

class EmployeeLoginPage extends StatefulWidget {
  const EmployeeLoginPage({super.key});

  @override
  State<EmployeeLoginPage> createState() => _EmployeeLoginPageState();
}

class _EmployeeLoginPageState extends State<EmployeeLoginPage> {
  var loginId = "";
  var password = "";
  bool check = false;

  Login() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'refreshToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQ5N2Q5M2M3LWRmZTgtNGY1My1hMDgxLTAwNzI2MWQ0MWNhYyIsImlhdCI6MTc4MTg2Nzc3NiwiZXhwIjoxNzg0NDU5Nzc2fQ.BPMLlCAbeEl-RSrfmRdSd4GiRIwhRSHeCqb2LtykHCM',
    };
    var request = http.Request(
      'POST',
      Uri.parse('https://hostelapistaging.pmu.org.in/student/login'),
    );
    request.body = json.encode({
      "loginId": "$loginId",
      "password": "$password",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmployeeHomeScreen()),
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User Id * "),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter User Id ",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xff94A3B8),
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xffCBD5E1)),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xff644EE5),
                        width: 2,
                      ),
                    ),
                  ),

                  onChanged: (value) => {loginId = value},
                ),
                SizedBox(height: 20),
                Text("Password * "),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter User password ",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xff94A3B8),
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xffCBD5E1)),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xff644EE5),
                        width: 2,
                      ),
                    ),
                  ),
                  onChanged: (value) => {password = value},
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print("object");
                          Login();
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          bool check = await Biomatricauthservice()
                              .authenticateLocally();

                          if (check) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmployeeHomeScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Login with Biometric",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
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
  }
}
