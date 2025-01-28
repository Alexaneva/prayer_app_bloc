abstract class MyPrayerDetailEvent {}

class LoadPrayerDetails extends MyPrayerDetailEvent {
  final int prayerId;

  LoadPrayerDetails(this.prayerId);
}

class SubscribeToPrayer extends MyPrayerDetailEvent {
  final int prayerId;

  SubscribeToPrayer(this.prayerId);
}

class UnsubscribeFromPrayer extends MyPrayerDetailEvent {
  final int prayerId;

  UnsubscribeFromPrayer(this.prayerId);
}

class AddComment extends MyPrayerDetailEvent {
  final String comment;
  final int prayerId;

  AddComment(this.comment, this.prayerId);
}

class IncreaseMyPrayers extends MyPrayerDetailEvent {
  final int prayerId;
  IncreaseMyPrayers(this.prayerId);
}
