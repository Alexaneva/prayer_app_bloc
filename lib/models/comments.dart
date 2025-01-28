import 'package:prayer_bloc/models/user.dart';

class Comment {
  final int id;
  final String body;
  final String createdAt;
  final DateTime? date;
  final User? user;

  Comment({required this.id, required this.body, required this.createdAt, this.date, this.user});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      body: json['body'],
      createdAt: json['createdAt'],
    );
  }
}