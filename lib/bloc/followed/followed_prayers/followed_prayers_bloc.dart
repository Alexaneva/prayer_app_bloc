import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/prayer.dart';
import '../../../services/followed_prayers_api_service.dart';
import 'followed_prayers_event.dart';
import 'followed_prayers_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final FollowedPrayersApiService apiService;

  SubscriptionBloc(this.apiService) : super(SubscriptionsLoading()) {
    on<LoadSubscriptions>(_loadCategories);
    on<UpdateFollowedPrayerColorEvent>((event, emit) {
      emit(FollowedColorIndicatorState(_getColorIndicator(event.prayer)));
    });
  }

  static Color _getColorIndicator(Prayer prayer) {
    if (prayer.lastPrayed == null) return Colors.grey;

    final duration = DateTime.now().difference(prayer.lastPrayed!);
    if (duration.inHours < 1) return Colors.blue;
    if (duration.inDays > 1) return Colors.red;
    return Colors.yellow;
  }

  Future<void> _loadCategories(
      LoadSubscriptions event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionsLoading());
    try {
      final prayers = await apiService.getSubscribedPrayers();
      emit(SubscriptionsLoaded(prayers));
    } catch (e) {
      emit(SubscriptionsError(e.toString()));
    }
  }
}
