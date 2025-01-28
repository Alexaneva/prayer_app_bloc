import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/prayer_category.dart';

class ApiServiceUserDesk {
  final String baseUrl;
  final String userDeskPath;

  ApiServiceUserDesk()
      : baseUrl = dotenv.env['BASE_URL'] ??
            (throw Exception('BASE_URL is not defined in .env')),
        userDeskPath = dotenv.env['MY_DESK'] ??
            (throw Exception('MY_DESK is not defined in .env'));

  Future<List<Category>> getUserCategories() async {
    final response = await http.get(Uri.parse('$baseUrl$userDeskPath'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((categoryJson) => Category(
                id: categoryJson['id'],
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

  Future<void> deleteUserCategory(int columnId) async {
    final response = await http.delete(Uri.parse('$baseUrl/columns/$columnId'));

    if (response.statusCode != 204) {
      // 204 no content
      throw Exception('Failed to delete category');
    }
  }

  Future<Category> addUserCategory(Category category) async {
    final response = await http.post(
      Uri.parse('$baseUrl/columns'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': category.title,
        'description': category.description,
      }),
    );

    if (response.statusCode != 201) {
      // 201 created
      throw Exception('Failed to add category');
    }
    final data = jsonDecode(response.body);
    return Category(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      deletedAt:
          data['deletedAt'] != null ? DateTime.parse(data['deletedAt']) : null,
    );
  }

  Future<void> updateUserCategory(int columnId, String newTitle) async {
    final response = await http.put(
      Uri.parse('$baseUrl/columns/$columnId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': newTitle,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }
}
