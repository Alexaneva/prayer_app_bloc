import '../../../models/comments.dart';
import '../../../models/prayer.dart';
import '../../../models/user.dart';

abstract class PrayerDetailState {}

class PrayerDetailInitial extends PrayerDetailState {}

class LoadingMyPrayersList extends PrayerDetailState {}

class PrayerDetailLoaded extends PrayerDetailState {
  final Prayer prayer;
  final List<Comment> comments;
  User? user;
  final DateTime? lastPrayedTime;
  final bool isFollowing;


  PrayerDetailLoaded(this.prayer, this.comments, this.lastPrayedTime, this.isFollowing);
}

class PrayerDetailError extends PrayerDetailState {
  final String error;

  PrayerDetailError(this.error);
}