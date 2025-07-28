import 'package:flutter/material.dart';
// import 'package:servexpert/View/Splesh_screen.dart';

import 'package:servxpert_frontend/constant/colors.dart';
import 'package:servxpert_frontend/launch/Splesh_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:servxpert_frontend/network/dio_client.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupDioWithCookies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.primary,
            onPrimary: Colors.white,
            secondary: AppColors.secondary,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            surface: Colors.white,
            onSurface: AppColors.textPrimary,
          ),
        ),

        home: SplashScreen()
    );
  }
}
