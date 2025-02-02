import 'package:go_router/go_router.dart';
import 'package:prayer_bloc/screens/main_screen/followed/followed_prayers/followed_prayers.dart';
import 'package:prayer_bloc/screens/main_screen/main_screen.dart';
import 'package:prayer_bloc/screens/main_screen/my_desk/my_prayers_list/my_prayers_list.dart';
import 'package:prayer_bloc/screens/main_screen/my_desk/prayer_details/my_prayer_details.dart';
import 'package:prayer_bloc/screens/authorisation/sign_up_screen.dart';
import 'package:prayer_bloc/screens/main_screen/user_desks/user_prayer_details/user_prayer_details.dart';
import 'package:prayer_bloc/screens/main_screen/user_desks/user_prayers/user_prayers_list.dart';

import '../screens/authorisation/sign_in_screen.dart';

class MyAppRouts {
  static final GoRouter router = GoRouter(
    initialLocation: '/sign-in',
    routes: [
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/main-screen',
        builder: (context, state) => MainScreen(),
      ),
      GoRoute(
        path: '/prayers/:columnId/:categoryTitle',
        builder: (context, state) {
          final columnId = int.parse(state.pathParameters['columnId']!);
          final categoryTitle =
              Uri.decodeComponent(state.pathParameters['categoryTitle']!);
          return MyPrayersList(
              columnId: columnId, categoryTitle: categoryTitle);
        },
      ),
      GoRoute(
        path: '/prayersDetails/:prayerId/:prayerTitle',
        builder: (context, state) {
          final prayerId = int.parse(state.pathParameters['prayerId']!);
          final prayerTitle =
              Uri.decodeComponent(state.pathParameters['prayerTitle']!);
          return MyDetailScreen(
            prayerTitle: prayerTitle,
            prayerId: prayerId,
          );
        },
      ),
      GoRoute(
        path: '/userPrayers/:columnId/:categoryTitle',
        builder: (context, state) {
          final columnId = int.parse(state.pathParameters['columnId']!);
          final categoryTitle =
          Uri.decodeComponent(state.pathParameters['categoryTitle']!);
          return UserPrayersList(
              columnId: columnId, categoryTitle: categoryTitle);
        },
      ),
      GoRoute(
        path: '/userPrayersDetails/:prayerId/:prayerTitle',
        builder: (context, state) {
          final prayerId = int.parse(state.pathParameters['prayerId']!);
          final prayerTitle =
          Uri.decodeComponent(state.pathParameters['prayerTitle']!);
          return UserDetailScreen(
            prayerTitle: prayerTitle,
            prayerId: prayerId,
          );
        },
      ),
      GoRoute(
        path: '/followedPrayersDetails/:prayerId/:prayerTitle',
        builder: (context, state) {
          final prayerId = int.parse(state.pathParameters['prayerId']!);
          final prayerTitle =
          Uri.decodeComponent(state.pathParameters['prayerTitle']!);
          return FollowedPrayers();
        },
      ),

    ],
  );
}
