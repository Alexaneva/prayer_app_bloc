
import '../../../models/prayer.dart';

abstract class SubscriptionEvent {}

class LoadSubscriptions extends SubscriptionEvent {}

class UpdateFollowedPrayer extends SubscriptionEvent {
  final int prayerId;
  final int columnId;
  final String newTitle;


  UpdateFollowedPrayer(this.prayerId, this.columnId, this.newTitle);
}

class UpdateFollowedPrayerColorEvent extends SubscriptionEvent {
  final Prayer prayer;

  UpdateFollowedPrayerColorEvent(this.prayer);
}
