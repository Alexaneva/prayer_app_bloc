import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/followed_prayer_detail_api_service.dart';

import 'followed_prayers_details_event.dart';
import 'followed_prayers_details_state.dart';

class FollowedPrayerDetailBloc
    extends Bloc<FollowedPrayerDetailEvent, FollowedPrayerDetailState> {
  final ApiControllerFollowedDeskDetails apiController;

  FollowedPrayerDetailBloc(this.apiController)
      : super(FollowedPrayerDetailInitial()) {
    on<LoadFollowedPrayerDetails>(_onLoadPrayerDetails);
    on<SubscribeToFollowedPrayer>(_onSubscribeToPrayer);
    on<UnsubscribeFromFollowedPrayer>(_onUnsubscribeFromPrayer);
    on<AddCommentF>(_onAddComment);
  }

  Future<void> _onLoadPrayerDetails(LoadFollowedPrayerDetails event,
      Emitter<FollowedPrayerDetailState> emit) async {
    try {
      emit(FollowedPrayerDetailInitial());
      final prayerData = await apiController.getPrayerDetails(event.prayerId);
      final comments = await apiController.getComments(event.prayerId);

      emit(FollowedPrayerDetailLoaded(prayerData, comments, null, false));
    } catch (e) {
      emit(FollowedPrayerDetailError('Failed to load prayer details'));
    }
  }

  Future<void> _onSubscribeToPrayer(SubscribeToFollowedPrayer event,
      Emitter<FollowedPrayerDetailState> emit) async {
    try {
      await apiController.subscribeToPrayer(event.prayerId);
    } catch (e) {
      emit(FollowedPrayerDetailError('Failed to subscribe to prayer'));
    }
  }

  Future<void> _onUnsubscribeFromPrayer(UnsubscribeFromFollowedPrayer event,
      Emitter<FollowedPrayerDetailState> emit) async {
    try {
      await apiController.unsubscribeFromPrayer(event.prayerId);
    } catch (e) {
      emit(FollowedPrayerDetailError('Failed to unsubscribe from prayer'));
    }
  }

  Future<void> _onAddComment(
      AddCommentF event, Emitter<FollowedPrayerDetailState> emit) async {
    try {
      final newComment =
          await apiController.createComment(event.prayerId, event.comment);
      if (state is FollowedPrayerDetailLoaded) {
        final currentState = state as FollowedPrayerDetailLoaded;
        emit(FollowedPrayerDetailLoaded(
            currentState.prayer,
            [
              ...currentState.comments,
              newComment,
            ],
            null,
            false));
      }
    } catch (e) {
      emit(FollowedPrayerDetailError('Failed to add comment'));
    }
  }
}
