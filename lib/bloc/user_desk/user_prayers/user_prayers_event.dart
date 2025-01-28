import '../../../models/prayer.dart';

abstract class UserPrayerEvent {}

class LoadUserPrayersList extends UserPrayerEvent {
  final int columnId;
  LoadUserPrayersList(this.columnId);
}

class DeleteUserPrayer extends UserPrayerEvent {
  final int prayerId;

  DeleteUserPrayer(this.prayerId);
}

class AddUserPrayer extends UserPrayerEvent {
  final Prayer prayer;

  AddUserPrayer(this.prayer);
}

class UpdateUserPrayer extends UserPrayerEvent {
  final int prayerId;
  final int columnId;
  final String newTitle;


  UpdateUserPrayer(this.prayerId, this.columnId, this.newTitle);
}

class UpdateUserPrayerColorEvent extends UserPrayerEvent {
  final Prayer prayer;

  UpdateUserPrayerColorEvent(this.prayer);
}
