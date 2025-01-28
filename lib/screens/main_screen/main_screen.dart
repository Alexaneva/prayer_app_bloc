
import 'package:flutter/material.dart';

import 'followed/followed_prayers/followed_prayers.dart';
import 'my_desk/my_desk/my_desk.dart';
import 'user_desks/user_desk/user_desks.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  late List<Widget> body;

  @override
  void initState() {
    super.initState();
    body = [
      const MyDesk(),
      const UserDesks(),
      const FollowedPrayers(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.sensor_door_sharp,
                color: currentIndex == 0 ? Colors.black : Colors.grey.shade500,
              ),
              label: 'My desk',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.view_quilt,
                color: currentIndex == 1 ? Colors.black : Colors.grey.shade500,
              ),
              label: 'Users desk',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.pets,
                color: currentIndex == 2 ? Colors.black : Colors.grey.shade500,
              ),
              label: 'Followed',
              backgroundColor: Colors.white,
            ),
          ]),
      body: body[currentIndex],
    );
  }
}
