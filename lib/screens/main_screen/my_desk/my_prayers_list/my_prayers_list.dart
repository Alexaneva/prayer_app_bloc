import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer_bloc/screens/main_screen/my_desk/my_prayers_list/widgets/my_prayers_list_item.dart';

import '../../../../app_images.dart';
import '../../../../bloc/my_desk/my_prayers_bloc/my_prayers_bloc.dart';
import '../../../../bloc/my_desk/my_prayers_bloc/my_prayers_event.dart';
import '../../../../bloc/my_desk/my_prayers_bloc/my_prayers_state.dart';

class MyPrayersList extends StatefulWidget {
  final int columnId;
  final String categoryTitle;

  const MyPrayersList(
      {super.key, required this.columnId, required this.categoryTitle});

  @override
  State<MyPrayersList> createState() => _MyPrayersListState();
}

class _MyPrayersListState extends State<MyPrayersList> {

  @override
  Widget build(BuildContext context) {
    context.read<MyPrayersBloc>().add(LoadMyPrayersList(widget.columnId));
    return BlocBuilder<MyPrayersBloc, MyPrayersState>(
      builder: (context, state) {
        if (state is LoadingMyPrayersList) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedMyPrayersList) {
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
                            image:
                            AssetImage(AppImages.noPrayers),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
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
                          return PrayerItem(prayer: prayer,);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is FailedLoadedMyPrayersList) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Container();
      },
    );
  }
}

