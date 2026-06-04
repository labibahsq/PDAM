import 'dart:convert';
import 'package:http/http.dart' as http;
import 'url.dart';

class AdminServices {
  Future<Map<String, dynamic>> loginAdmin(
    String username,
    String password,
  ) async {
    try {
      final url = Uri.parse('${AppUrl.baseUrl}/auth');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'app-key': AppUrl.appKey,
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print("STATUS CODE : ${response.statusCode}");
      print("BODY : ${response.body}");

      return jsonDecode(response.body);
    } catch (e) {
      return {
        'success': false,
        'message': 'Tidak dapat terhubung ke server.',
      };
    }
  }
}