import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/prayer.dart';

class ApiServicePrayerMyDesk {
  final String baseUrl;

  ApiServicePrayerMyDesk()
      : baseUrl = dotenv.env['BASE_URL'] ??
      (throw Exception('BASE_URL is not defined in .env'));

  Future<List<Prayer>> getMyPrayers(int columnId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/columns/$columnId/prayers'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((categoryJson) => Prayer(
                prayerId: categoryJson['id'],
                userId: categoryJson['userId'],
                title: categoryJson['name'],
                description: '',
                createdAt: DateTime.parse(categoryJson['createdAt']),
                updatedAt: DateTime.parse(categoryJson['updatedAt']),
                deletedAt: categoryJson['deletedAt'] != null
                    ? DateTime.parse(categoryJson['deletedAt'])
                    : null,
              ))
          .toList();
    } else {
      throw Exception('Failed to load my desks');
    }
  }

  Future<void> deleteMyPrayer(int prayerId) async {
    final response = await http.delete(Uri.parse('$baseUrl/prayers/$prayerId'));

    if (response.statusCode != 204) {
      // 204 no content
      throw Exception('Failed to delete category');
    }
  }

  Future<Prayer> addMyPrayer(int columnId, Prayer prayer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/columns/$columnId/prayers'),
      body: jsonEncode({
        'title': prayer.title,
        'description': prayer.description,
      }),
    );

    if (response.statusCode != 201) {
      // 201 created
      throw Exception('Failed to add category');
    }
    final data = jsonDecode(response.body);
    return Prayer(
      prayerId: data['id'],
      userId: data['userId'],
      title: data['title'],
      description: data['description'],
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      deletedAt:
          data['deletedAt'] != null ? DateTime.parse(data['deletedAt']) : null,
    );
  }

  Future<void> updateMyPrayer(
      int columnId, int prayerId, String newTitle) async {
    final response = await http.put(
      Uri.parse('$baseUrl/columns/$columnId/prayers/$prayerId'),
      body: jsonEncode({
        'title': newTitle,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }
}
