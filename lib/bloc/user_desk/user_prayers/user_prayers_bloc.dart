
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_bloc/bloc/user_desk/user_prayers/user_prayers_event.dart';
import 'package:prayer_bloc/bloc/user_desk/user_prayers/user_prayers_state.dart';

import '../../../models/prayer.dart';
import '../../../services/user_prayers_api_service.dart';

class UserPrayersBloc extends Bloc<UserPrayerEvent, UserPrayersState> {
  final ApiServicePrayerUserDesk apiServicePrayerMyDesk;

  UserPrayersBloc(this.apiServicePrayerMyDesk) : super(InitialUserPrayersList()) {

    on<LoadUserPrayersList>((event, emit) async {
      emit(LoadingUserPrayersList());
      try {
        final prayers = await apiServicePrayerMyDesk.getUserPrayers(event.columnId);
        emit(LoadedUserPrayersList(prayers));
      } catch (e) {
        emit(FailedLoadedUserPrayersList(e.toString()));
      }
    });

    on<DeleteUserPrayer>((event,emit) async {
      try {
        await apiServicePrayerMyDesk.deleteUserPrayer(event.prayerId);
        add(LoadUserPrayersList(event.prayerId));
      } catch (e) {
        emit(FailedLoadedUserPrayersList(e.toString()));
      }
    });

    on <UpdateUserPrayer>((event, emit) async {
      try{
        await apiServicePrayerMyDesk.updateUserPrayer(event.columnId, event.prayerId, event.newTitle);
        add (LoadUserPrayersList(event.prayerId));
      } catch (e) {
        emit(FailedLoadedUserPrayersList(e.toString()));
      }
    });

    on<UpdateUserPrayerColorEvent>((event, emit) {
      emit(UserColorIndicatorState(_getColorIndicator(event.prayer)));
    });
  }
  static Color _getColorIndicator(Prayer prayer) {
    if (prayer.lastPrayed == null) return Colors.grey;

    final duration = DateTime.now().difference(prayer.lastPrayed!);
    if (duration.inHours < 1) return Colors.blue;
    if (duration.inDays > 1) return Colors.red;
    return Colors.yellow;
  }
}