import 'dart:ui';

import '../../../models/prayer.dart';

abstract class SubscriptionState {}

class SubscriptionsLoading extends SubscriptionState {}

class SubscriptionsLoaded extends SubscriptionState {
  final List<Prayer> prayers;

  SubscriptionsLoaded(this.prayers);
}

class SubscriptionsError extends SubscriptionState {
  final String message;

  SubscriptionsError(this.message);
}

class FollowedPrayerUpdated extends SubscriptionState {}

class FollowedColorIndicatorState extends SubscriptionState {
  final Color color;

  FollowedColorIndicatorState(this.color);
}
