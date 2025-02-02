import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer_bloc/screens/main_screen/user_desks/user_prayers/widgets/user_prayers_list_item.dart';

import '../../../../app_widgets/app_colors.dart';
import '../../../../app_widgets/app_images.dart';
import '../../../../bloc/user_desk/user_prayers/user_prayers_bloc.dart';
import '../../../../bloc/user_desk/user_prayers/user_prayers_event.dart';
import '../../../../bloc/user_desk/user_prayers/user_prayers_state.dart';

class UserPrayersList extends StatefulWidget {
  final int columnId;
  final String categoryTitle;

  const UserPrayersList(
      {super.key, required this.columnId, required this.categoryTitle});

  @override
  State<UserPrayersList> createState() => _UserPrayersListState();
}

class _UserPrayersListState extends State<UserPrayersList> {
  @override
  Widget build(BuildContext context) {
    context.read<UserPrayersBloc>().add(LoadUserPrayersList(widget.columnId));
    return BlocBuilder<UserPrayersBloc, UserPrayersState>(
      builder: (context, state) {
        if (state is LoadingUserPrayersList) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedUserPrayersList) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.categoryTitle),
              actions: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: state.prayers.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.noPrayers),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                image: AssetImage(AppImages.backGround),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ListView.builder(
                              itemCount: state.prayers.length,
                              itemBuilder: (context, index) {
                                final prayer = state.prayers[index];
                                return UserPrayerItem(
                                  prayer: prayer,
                                );
                              },
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        } else if (state is FailedLoadedUserPrayersList) {
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
