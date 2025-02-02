import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_widgets/app_colors.dart';
import '../../../../app_widgets/custom_button.dart';
import '../../../../bloc/user_desk/user_details_prayer_bloc/user_details_prayer_bloc.dart';
import '../../../../bloc/user_desk/user_details_prayer_bloc/user_details_prayer_event.dart';
import '../../../../bloc/user_desk/user_details_prayer_bloc/user_details_prayer_state.dart';
import '../../../../text_editing_сontrollers/auth_text_editing_сontrollers.dart';
import 'widgets/user_comments_section.dart';
import 'widgets/user_prayer_statistics_grid.dart';

class UserDetailScreen extends StatefulWidget {
  final int prayerId;
  final String prayerTitle;

  const UserDetailScreen(
      {super.key, required this.prayerTitle, required this.prayerId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context
        .read<UserPrayerDetailBloc>()
        .add(LoadUserPrayerDetails(widget.prayerId));
    return BlocBuilder<UserPrayerDetailBloc, UserPrayerDetailState>(
      builder: (context, state) {
        if (state is UserPrayerDetailLoaded) {
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
                  child: UserPrayerStatisticsGrid(
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
                        context
                            .read<UserPrayerDetailBloc>()
                            .add(IncreaseUserPrayers(state.prayer.prayerId));
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
                        context
                            .read<UserPrayerDetailBloc>()
                            .add(SubscribeToUserPrayer(state.prayer.prayerId));
                      } else {
                        context
                            .read<UserPrayerDetailBloc>()
                            .add(UnsubscribeFromUserPrayer(state.prayer.prayerId));
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
                UserCommentSection(
                  commentController: commentController,
                  prayerId: widget.prayerId.toString(),
                  comments: state.comments,
                ),
              ],
            ),
          );
        } else if (state is UserPrayerDetailError) {
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
