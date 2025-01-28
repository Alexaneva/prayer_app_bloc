import 'package:flutter/material.dart';

import '../../../../../app_images.dart';
import '../../../../../models/prayer.dart';

class FollowedPrayerStatisticsGrid extends StatelessWidget {
  final Prayer state;

  const FollowedPrayerStatisticsGrid({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backGround),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _buildStatCard('Date', state.lastPrayed?.toString() ?? DateTime.now().toString());
            case 1:
              return _buildStatCard('Total prayers', ((state.otherPrayers ?? 0) + (state.myPrayers ?? 0)).toString());
            case 2:
              return _buildStatCard('Other prayers', (state.otherPrayers ?? 0).toString());
            case 3:
              return _buildStatCard('My prayers', (state.myPrayers ?? 0).toString());
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}