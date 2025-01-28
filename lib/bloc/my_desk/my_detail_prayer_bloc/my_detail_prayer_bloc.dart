import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/my_prayer_detail_api_service.dart';
import 'my_detail_prayer_event.dart';
import 'my_detail_prayer_state.dart';

class MyPrayerDetailBloc extends Bloc<MyPrayerDetailEvent, PrayerDetailState> {
  final ApiControllerMyDeskDetails apiController;

  MyPrayerDetailBloc(this.apiController) : super(PrayerDetailInitial()) {
    on<LoadPrayerDetails>(_onLoadPrayerDetails);
    on<SubscribeToPrayer>(_onSubscribeToPrayer);
    on<UnsubscribeFromPrayer>(_onUnsubscribeFromPrayer);
    on<AddComment>(_onAddComment);
  }

  Future<void> _onLoadPrayerDetails(
      LoadPrayerDetails event, Emitter<PrayerDetailState> emit) async {
    try {
      emit(PrayerDetailInitial());
      final prayerData = await apiController.getPrayerDetails(event.prayerId);
      final comments = await apiController.getComments(event.prayerId);

      emit(PrayerDetailLoaded(prayerData, comments, null, false));
    } catch (e) {
      emit(PrayerDetailError('Failed to load prayer details'));
    }
  }

  Future<void> _onSubscribeToPrayer(
      SubscribeToPrayer event, Emitter<PrayerDetailState> emit) async {
    try {
      await apiController.subscribeToPrayer(event.prayerId);
    } catch (e) {
      emit(PrayerDetailError('Failed to subscribe to prayer'));
    }
  }

  Future<void> _onUnsubscribeFromPrayer(
      UnsubscribeFromPrayer event, Emitter<PrayerDetailState> emit) async {
    try {
      await apiController.unsubscribeFromPrayer(event.prayerId);
    } catch (e) {
      emit(PrayerDetailError('Failed to unsubscribe from prayer'));
    }
  }

  Future<void> _onAddComment(
      AddComment event, Emitter<PrayerDetailState> emit) async {
    try {
      final newComment =
      await apiController.createComment(event.prayerId, event.comment);
      if (state is PrayerDetailLoaded) {
        final currentState = state as PrayerDetailLoaded;
        emit(PrayerDetailLoaded(
            currentState.prayer,
            [
              ...currentState.comments,
              newComment,
            ],
            null,
            false));
      }
    } catch (e) {
      emit(PrayerDetailError('Failed to add comment'));
    }
  }
}
