import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hrms/Models/all_Users.dart';

class ApiServices {
  Future<AllUser?> getAllUsers() async {
    try {
      const String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImEwZTYyOWY4LTUzYzYtNDc0OC04YWUxLTg1MTAzYjRhNjYzNyIsImVtYWlsIjoiYXNoaXNoQGdtYWlsLmNvbSIsInVpZCI6bnVsbCwicm9sZSI6ImFkbWluIiwic3R1ZGVudElkIjoiYTBlNjI5ZjgtNTNjNi00NzQ4LThhZTEtODUxMDNiNGE2NjM3IiwiZmlyc3ROYW1lIjoiQXNoaXNoIiwibGFzdE5hbWUiOiJLdW1hciIsImlhdCI6MTc4MjcxOTU4MCwiZXhwIjoxNzg1MzExNTgwfQ.Ci0Mrx7L1i0ZnGIX5vYCcc03xof-eVuTUEocujh057Q";
      var response = await http.get(
        Uri.parse("http://localhost:8001/user/all-users"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final model = AllUser.fromJson(jsonDecode(response.body));
        return model;
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
    return null;
  }
}





