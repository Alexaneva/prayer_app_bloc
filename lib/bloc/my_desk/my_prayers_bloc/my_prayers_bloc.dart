
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/prayer.dart';
import '../../../services/my_prayers_api_service.dart';
import 'my_prayers_event.dart';
import 'my_prayers_state.dart';

class MyPrayersBloc extends Bloc<MyPrayerEvent, MyPrayersState> {
  final ApiServicePrayerMyDesk apiServicePrayerMyDesk;

  MyPrayersBloc(this.apiServicePrayerMyDesk) : super(InitialMyPrayersList()) {

    on<LoadMyPrayersList>((event, emit) async {
      emit(LoadingMyPrayersList());
      try {
        final prayers = await apiServicePrayerMyDesk.getMyPrayers(event.columnId);
        emit(LoadedMyPrayersList(prayers));
      } catch (e) {
        emit(FailedLoadedMyPrayersList(e.toString()));
      }
    });

    on<DeleteMyPrayer>((event,emit) async {
      try {
        await apiServicePrayerMyDesk.deleteMyPrayer(event.prayerId);
        add(LoadMyPrayersList(event.prayerId));
      } catch (e) {
        emit(FailedLoadedMyPrayersList(e.toString()));
      }
    });

    on <UpdateMyPrayer>((event, emit) async {
      try{
        await apiServicePrayerMyDesk.updateMyPrayer(event.columnId, event.prayerId, event.newTitle);
        add (LoadMyPrayersList(event.prayerId));
      } catch (e) {
        emit(FailedLoadedMyPrayersList(e.toString()));
      }
    });

    on<UpdatePrayerColorEvent>((event, emit) {
      emit(ColorIndicatorState(_getColorIndicator(event.prayer)));
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

