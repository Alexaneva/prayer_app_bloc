import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer_bloc/screens/main_screen/followed/followed_details_prayer/widgets/comments_section_followed_prayer.dart';
import 'package:prayer_bloc/screens/main_screen/followed/followed_details_prayer/widgets/followed_prayer_statistic.dart';

import '../../../../app_widgets/app_colors.dart';
import '../../../../app_widgets/custom_button.dart';
import '../../../../bloc/followed/followed_prayers_details/followed_prayers_details_bloc.dart';
import '../../../../bloc/followed/followed_prayers_details/followed_prayers_details_event.dart';
import '../../../../bloc/followed/followed_prayers_details/followed_prayers_details_state.dart';
import '../../../../text_editing_сontrollers/auth_text_editing_сontrollers.dart';

class FollowedPrayerDetailScreen extends StatefulWidget {
  final int prayerId;
  final String prayerTitle;

  const FollowedPrayerDetailScreen(
      {super.key, required this.prayerTitle, required this.prayerId});

  @override
  State<FollowedPrayerDetailScreen> createState() =>
      _FollowedPrayerDetailScreenState();
}

class _FollowedPrayerDetailScreenState
    extends State<FollowedPrayerDetailScreen> {
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context
        .read<FollowedPrayerDetailBloc>()
        .add(LoadFollowedPrayerDetails(widget.prayerId));
    return BlocBuilder<FollowedPrayerDetailBloc, FollowedPrayerDetailState>(
      builder: (context, state) {
        if (state is LoadingMyPrayersList) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FollowedPrayerDetailLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.prayerTitle),
              actions: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FollowedPrayerStatisticsGrid(
                    state: state.prayer,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 400.0,
                  height: 55.0,
                  child: CustomElevatedButton(
                    text: 'Prayed',
                    onPressed: () {
                      final now = DateTime.now();
                      if (state.prayer.lastPrayed == null ||
                          now.difference(state.prayer.lastPrayed!).inHours >=
                              1) {
                        context.read<FollowedPrayerDetailBloc>().add(
                            IncreaseFollowedPrayers(state.prayer.prayerId));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                'The counter can be pressed once per hour'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Ok'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    backgroundColor:
                        AuthTextEditingControllers.isSignInFormFilled
                            ? AppColors.grayScale800
                            : AppColors.grayScale300,
                    foregroundColor: AppColors.grayScale100,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 400.0,
                  height: 55.0,
                  child: CustomElevatedButton(
                    text: !state.isFollowing ? 'Following ✓' : 'Follow',
                    onPressed: () {
                      if (!state.isFollowing) {
                        context.read<FollowedPrayerDetailBloc>().add(
                            SubscribeToFollowedPrayer(state.prayer.prayerId));
                      } else {
                        context.read<FollowedPrayerDetailBloc>().add(
                            UnsubscribeFromFollowedPrayer(
                                state.prayer.prayerId));
                      }
                    },
                    backgroundColor:
                        AuthTextEditingControllers.isSignInFormFilled
                            ? AppColors.grayScale800
                            : AppColors.grayScale300,
                    foregroundColor: AppColors.grayScale100,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 1.0,
                  color: Colors.grey[200],
                  width: double.infinity,
                ),
                const SizedBox(height: 10),
                CommentSectionFollowedPrayer(
                  commentController: commentController,
                  prayerId: widget.prayerId.toString(),
                  comments: state.comments,
                ),
              ],
            ),
          );
        } else if (state is FollowedPrayerDetailError) {
          return Center(
              child: Text(
            'Error: ${state.error}',
            style: TextStyle(color: AppColors.error),
          ));
        }
        return Container();
      },
    );
  }
}
