abstract class FollowedPrayerDetailEvent {}

class LoadFollowedPrayerDetails extends FollowedPrayerDetailEvent {
  final int prayerId;

  LoadFollowedPrayerDetails(this.prayerId);
}

class SubscribeToFollowedPrayer extends FollowedPrayerDetailEvent {
  final int prayerId;

  SubscribeToFollowedPrayer(this.prayerId);
}

class UnsubscribeFromFollowedPrayer extends FollowedPrayerDetailEvent {
  final int prayerId;

  UnsubscribeFromFollowedPrayer(this.prayerId);
}

class AddCommentF extends FollowedPrayerDetailEvent {
  final String comment;
  final int prayerId;

  AddCommentF(this.comment, this.prayerId);
}

class IncreaseFollowedPrayers extends FollowedPrayerDetailEvent {
  final int prayerId;
  IncreaseFollowedPrayers(this.prayerId);
}
