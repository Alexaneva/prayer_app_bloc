class Prayer {
  final int prayerId;
  final int userId;
  String title;
  String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final DateTime? lastPrayed;
  final bool? isFollowing;
  final int? otherPrayers;
  final int? myPrayers;


  Prayer({
    required this.prayerId,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    this.isFollowing,
    this.lastPrayed,
    this.myPrayers,
    this.otherPrayers,
  });
}