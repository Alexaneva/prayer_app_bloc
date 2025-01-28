class Category {
  final int id;
  String title;
  String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Category({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
}