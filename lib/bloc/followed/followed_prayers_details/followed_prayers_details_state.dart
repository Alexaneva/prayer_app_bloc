import '../../../models/comments.dart';
import '../../../models/prayer.dart';
import '../../../models/user.dart';

abstract class FollowedPrayerDetailState {}

class FollowedPrayerDetailInitial extends FollowedPrayerDetailState {}

class LoadingMyPrayersList extends FollowedPrayerDetailState {}

class FollowedPrayerDetailLoaded extends FollowedPrayerDetailState {
  final Prayer prayer;
  final List<Comment> comments;
  User? user;
  final DateTime? lastPrayedTime;
  final bool isFollowing;


  FollowedPrayerDetailLoaded(this.prayer, this.comments, this.lastPrayedTime, this.isFollowing);
}

class FollowedPrayerDetailError extends FollowedPrayerDetailState {
  final String error;

  FollowedPrayerDetailError(this.error);
}