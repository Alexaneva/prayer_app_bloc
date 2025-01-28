class User {
  final int id;
  final String email;
  final String name;
  final String token;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}