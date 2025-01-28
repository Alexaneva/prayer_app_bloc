import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/comments.dart';
import '../models/prayer.dart';

class ApiControllerFollowedDeskDetails {
  final String baseUrl;

  ApiControllerFollowedDeskDetails()
      : baseUrl = dotenv.env['BASE_URL'] ??
      (throw Exception('BASE_URL is not defined in .env'));

  Future<Prayer> getPrayerDetails(int prayerId) async {
    final response = await http.get(Uri.parse('$baseUrl/prayers/$prayerId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return Prayer(
        prayerId: data['id'],
        userId: data['userId'],
        title: data['title'],
        description: data['description'] ?? '',
        createdAt: DateTime.parse(data['createdAt']),
        updatedAt: DateTime.parse(data['updatedAt']),
        deletedAt: data['deletedAt'] != null
            ? DateTime.parse(data['deletedAt'])
            : null,
      );
    } else {
      throw Exception('Failed to load prayer details');
    }
  }

  Future<Map<String, dynamic>> subscribeToPrayer(int prayerId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/prayers/$prayerId/subscribe'),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> unsubscribeFromPrayer(int prayerId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/prayers/$prayerId/subscribe'),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> completePrayer(int prayerId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/prayers/$prayerId/complete'),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> doPrayer(int prayerId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/prayers/$prayerId/do'),
    );
    return jsonDecode(response.body);
  }

  Future<List<Comment>> getComments(int prayerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/prayers/$prayerId/comments'),
    );
    final data = jsonDecode(response.body);
    return (data['data'] as List)
        .map((comment) => Comment.fromJson(comment))
        .toList();
  }

  Future<Comment> createComment(int prayerId, String body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/prayers/$prayerId/comments'),
      body: jsonEncode({'body': body}),
      headers: {'Content-Type': 'application/json'},
    );
    return Comment.fromJson(jsonDecode(response.body));
  }
}
