abstract class UserPrayerDetailEvent {}

class LoadUserPrayerDetails extends UserPrayerDetailEvent {
  final int prayerId;

  LoadUserPrayerDetails(this.prayerId);
}

class SubscribeToUserPrayer extends UserPrayerDetailEvent {
  final int prayerId;

  SubscribeToUserPrayer(this.prayerId);
}

class UnsubscribeFromUserPrayer extends UserPrayerDetailEvent {
  final int prayerId;

  UnsubscribeFromUserPrayer(this.prayerId);
}

class AddUserComment extends UserPrayerDetailEvent {
  final String comment;
  final int prayerId;

  AddUserComment(this.comment, this.prayerId);
}

class IncreaseUserPrayers extends UserPrayerDetailEvent {
  final int prayerId;
  IncreaseUserPrayers(this.prayerId);
}
