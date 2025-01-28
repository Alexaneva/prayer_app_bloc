import 'dart:ui';

import '../../../models/prayer.dart';



abstract class UserPrayersState {}

class InitialUserPrayersList extends UserPrayersState {}

class LoadingUserPrayersList extends UserPrayersState {}

class LoadedUserPrayersList extends UserPrayersState {
  final List<Prayer> prayers;

  LoadedUserPrayersList(this.prayers);
}

class FailedLoadedUserPrayersList extends UserPrayersState {
  final String error;

  FailedLoadedUserPrayersList(this.error);
}

class PrayerAdded extends UserPrayersState {}

class PrayerDeleted extends UserPrayersState {}

class PrayerUpdated extends UserPrayersState {}

class UserColorIndicatorState extends UserPrayersState {
  final Color color;

  UserColorIndicatorState(this.color);
}

