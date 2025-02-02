import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer_bloc/app_widgets/custom_button.dart';
import 'package:prayer_bloc/screens/main_screen/my_desk/prayer_details/widgets/comments_section.dart';
import 'package:prayer_bloc/screens/main_screen/my_desk/prayer_details/widgets/prayer_statistics_grid.dart';

import '../../../../app_widgets/app_colors.dart';
import '../../../../bloc/my_desk/my_detail_prayer_bloc/my_detail_prayer_bloc.dart';
import '../../../../bloc/my_desk/my_detail_prayer_bloc/my_detail_prayer_event.dart';
import '../../../../bloc/my_desk/my_detail_prayer_bloc/my_detail_prayer_state.dart';
import '../../../../text_editing_сontrollers/auth_text_editing_сontrollers.dart';

class MyDetailScreen extends StatefulWidget {
  final int prayerId;
  final String prayerTitle;

  const MyDetailScreen(
      {super.key, required this.prayerTitle, required this.prayerId});

  @override
  State<MyDetailScreen> createState() => _MyDetailScreenState();
}

class _MyDetailScreenState extends State<MyDetailScreen> {
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<MyPrayerDetailBloc>().add(LoadPrayerDetails(widget.prayerId));
    return BlocBuilder<MyPrayerDetailBloc, PrayerDetailState>(
      builder: (context, state) {
        if (state is LoadingMyPrayersList) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PrayerDetailLoaded) {
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
                  child: PrayerStatisticsGrid(
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
                            .read<MyPrayerDetailBloc>()
                            .add(IncreaseMyPrayers(state.prayer.prayerId));
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
                            .read<MyPrayerDetailBloc>()
                            .add(SubscribeToPrayer(state.prayer.prayerId));
                      } else {
                        context
                            .read<MyPrayerDetailBloc>()
                            .add(UnsubscribeFromPrayer(state.prayer.prayerId));
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
                CommentSection(
                  commentController: commentController,
                  prayerId: widget.prayerId.toString(),
                  comments: state.comments,
                ),
              ],
            ),
          );
        } else if (state is PrayerDetailError) {
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
