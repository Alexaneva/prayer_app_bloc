import '../../../models/prayer.dart';

abstract class MyPrayerEvent {}

class LoadMyPrayersList extends MyPrayerEvent {
  final int columnId;
  LoadMyPrayersList(this.columnId);
}

class DeleteMyPrayer extends MyPrayerEvent {
  final int prayerId;

  DeleteMyPrayer(this.prayerId);
}

class AddMyPrayer extends MyPrayerEvent {
  final Prayer prayer;

  AddMyPrayer(this.prayer);
}

class UpdateMyPrayer extends MyPrayerEvent {
  final int prayerId;
  final int columnId;
  final String newTitle;


  UpdateMyPrayer(this.prayerId, this.columnId, this.newTitle);
}

class UpdatePrayerColorEvent extends MyPrayerEvent {
  final Prayer prayer;

  UpdatePrayerColorEvent(this.prayer);
}
