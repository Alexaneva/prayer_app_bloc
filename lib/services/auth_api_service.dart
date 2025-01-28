import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class AuthApiService {
  final String baseUrl;
  final String signInPath;
  final String signUpPath;

  AuthApiService()
      : baseUrl = dotenv.env['BASE_URL'] ?? (throw Exception('BASE_URL is not defined in .env')),
        signInPath = dotenv.env['SIGN_IN_PATH'] ?? (throw Exception('SIGN_IN_PATH is not defined in .env')),
        signUpPath = dotenv.env['SIGN_UP_PATH'] ?? (throw Exception('SIGN_UP_PATH is not defined in .env'));

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl$signInPath'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> signUp(String email, String name, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl$signUpPath'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'name': name, 'password': password}),
    );
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

