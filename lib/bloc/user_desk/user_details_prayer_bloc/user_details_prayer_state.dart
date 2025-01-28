import '../../../models/comments.dart';
import '../../../models/prayer.dart';
import '../../../models/user.dart';

abstract class UserPrayerDetailState {}

class UserPrayerDetailInitial extends UserPrayerDetailState {}

class LoadingUserPrayersList extends UserPrayerDetailState {}

class UserPrayerDetailLoaded extends UserPrayerDetailState {
  final Prayer prayer;
  final List<Comment> comments;
  User? user;
  final DateTime? lastPrayedTime;
  final bool isFollowing;


  UserPrayerDetailLoaded(this.prayer, this.comments, this.lastPrayedTime, this.isFollowing);
}

class UserPrayerDetailError extends UserPrayerDetailState {
  final String error;

  UserPrayerDetailError(this.error);
}