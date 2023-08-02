import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroy_app/controllers/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  LoginController loginController = Get.put(LoginController());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    final SharedPreferences? prefs = await _prefs;

    if (prefs?.get('token') == null) {
      _navigateToLogin();
    } else {
      _navigateToHome();
    }
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushNamed(context, "/home");
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Image(
            image: AssetImage('assets/images/logoletter.png'),
          ),
        ),
      ),
    );
  }
}
