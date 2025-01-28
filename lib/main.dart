import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prayer_bloc/services/auth_api_service.dart';

import 'app_routes.dart';
import 'bloc/auth_bloc/auth_bloc.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = AuthApiService();
    return BlocProvider(
      create: (context) => AuthBloc(apiService),
      child: MaterialApp.router(
        routerConfig: MyAppRouts.router,
      ),
    );
  }
}

