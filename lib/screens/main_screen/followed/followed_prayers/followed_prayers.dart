import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_bloc/screens/main_screen/followed/followed_prayers/widgets/followed_prayers_list_item.dart';

import '../../../../app_images.dart';
import '../../../../bloc/followed/followed_prayers/followed_prayers_bloc.dart';
import '../../../../bloc/followed/followed_prayers/followed_prayers_event.dart';
import '../../../../bloc/followed/followed_prayers/followed_prayers_state.dart';


class FollowedPrayers extends StatefulWidget {
  const FollowedPrayers({super.key});

  @override
  State<FollowedPrayers> createState() => _FollowedPrayersState();
}

class _FollowedPrayersState extends State<FollowedPrayers> {
  @override
  Widget build(BuildContext context) {
    context.read<SubscriptionBloc>().add(LoadSubscriptions());
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
       if (state is SubscriptionsLoaded) {
          return Scaffold(
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
                          return FollowedPrayersItem(prayer: prayer,);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is SubscriptionsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }
}