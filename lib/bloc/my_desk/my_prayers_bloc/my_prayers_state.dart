import 'dart:ui';

import '../../../models/prayer.dart';



abstract class MyPrayersState {}

class InitialMyPrayersList extends MyPrayersState {}

class LoadingMyPrayersList extends MyPrayersState {}

class LoadedMyPrayersList extends MyPrayersState {
  final List<Prayer> prayers;

  LoadedMyPrayersList(this.prayers);
}

class FailedLoadedMyPrayersList extends MyPrayersState {
  final String error;

  FailedLoadedMyPrayersList(this.error);
}

class PrayerAdded extends MyPrayersState {}

class PrayerDeleted extends MyPrayersState {}

class PrayerUpdated extends MyPrayersState {}

class ColorIndicatorState extends MyPrayersState {
  final Color color;

  ColorIndicatorState(this.color);
}

