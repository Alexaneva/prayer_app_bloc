


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_bloc/bloc/user_desk/user_details_prayer_bloc/user_details_prayer_event.dart';
import 'package:prayer_bloc/bloc/user_desk/user_details_prayer_bloc/user_details_prayer_state.dart';

import '../../../services/user_prayer_details_api_service.dart';

class UserPrayerDetailBloc extends Bloc<UserPrayerDetailEvent, UserPrayerDetailState> {
  final ApiControllerUserDeskDetails apiController;

  UserPrayerDetailBloc(this.apiController) : super(UserPrayerDetailInitial()) {
    on<LoadUserPrayerDetails>(_onLoadPrayerDetails);
    on<SubscribeToUserPrayer>(_onSubscribeToPrayer);
    on<UnsubscribeFromUserPrayer>(_onUnsubscribeFromPrayer);
    on<AddUserComment>(_onAddComment);
  }

  Future<void> _onLoadPrayerDetails(
      LoadUserPrayerDetails event, Emitter<UserPrayerDetailState> emit) async {
    try {
      emit(UserPrayerDetailInitial());
      final prayerData = await apiController.getPrayerDetails(event.prayerId);
      final comments = await apiController.getComments(event.prayerId);

      emit(UserPrayerDetailLoaded(prayerData, comments, null, false));
    } catch (e) {
      emit(UserPrayerDetailError('Failed to load prayer details'));
    }
  }

  Future<void> _onSubscribeToPrayer(
      SubscribeToUserPrayer event, Emitter<UserPrayerDetailState> emit) async {
    try {
      await apiController.subscribeToPrayer(event.prayerId);
    } catch (e) {
      emit(UserPrayerDetailError('Failed to subscribe to prayer'));
    }
  }

  Future<void> _onUnsubscribeFromPrayer(
      UnsubscribeFromUserPrayer event, Emitter<UserPrayerDetailState> emit) async {
    try {
      await apiController.unsubscribeFromPrayer(event.prayerId);
    } catch (e) {
      emit(UserPrayerDetailError('Failed to unsubscribe from prayer'));
    }
  }

  Future<void> _onAddComment(
      AddUserComment event, Emitter<UserPrayerDetailState> emit) async {
    try {
      final newComment =
      await apiController.createComment(event.prayerId, event.comment);
      if (state is UserPrayerDetailLoaded) {
        final currentState = state as UserPrayerDetailLoaded;
        emit(UserPrayerDetailLoaded(
            currentState.prayer,
            [
              ...currentState.comments,
              newComment,
            ],
            null,
            false));
      }
    } catch (e) {
      emit(UserPrayerDetailError('Failed to add comment'));
    }
  }
}
