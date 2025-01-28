import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/prayer.dart';

class FollowedPrayersApiService {
  final String baseUrl;
  final String followedPath;

  FollowedPrayersApiService()
      : baseUrl = dotenv.env['BASE_URL'] ??
            (throw Exception('BASE_URL is not defined in .env')),
        followedPath = dotenv.env['FOLLOWED'] ??
            (throw Exception('FOLLOWED is not defined in .env'));

  Future<List<Prayer>> getSubscribedPrayers() async {
    final response = await http.get(Uri.parse('$baseUrl$followedPath'));

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
}
