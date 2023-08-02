import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroy_app/pages/home.dart';
import 'package:stroy_app/pages/login.dart';
import 'package:stroy_app/pages/registration.dart';
import 'package:stroy_app/pages/splash.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Story App',
      routes: {
        '/': (context) => const Splash(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/home': (context) => const MyHomePage()
      },
    );
  }
}
