import 'dart:convert';
import 'package:http/http.dart' as http;
import 'url.dart';

class CustomerServices {
  Future<Map<String, dynamic>> loginCustomer(
    String username,
    String password,
  ) async {
    try {
      final url = Uri.parse('${AppUrl.baseUrl}/auth');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'app-key': AppUrl.appKey},
        body: jsonEncode({'username': username, 'password': password}),
      );

      print("STATUS CODE : ${response.statusCode}");
      print("BODY : ${response.body}");

      final responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        return {
          'success': true,
          'data': responseData,
          'message': responseData['message'],
        };
      }

      return {
        'success': false,
        'message': responseData['message'] ?? 'Username atau password salah.',
      };
    } catch (e) {
      print(e);

      return {
        'success': false,
        'message': 'Tidak dapat terhubung ke server. Periksa koneksi internet.',
      };
    }
  }
}
