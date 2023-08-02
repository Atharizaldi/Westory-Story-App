import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String _baseUrl = 'https://story-api.dicoding.dev/v1/';

  Future<bool> login() async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse("${_baseUrl}login");

    Map body = {
      'email': emailController.text.trim(),
      'password': passwordController.text
    };

    http.Response responsee =
        await http.post(url, body: jsonEncode(body), headers: headers);

    if (responsee.statusCode == 200) {
      final data = jsonDecode(responsee.body);

      var token = data['loginResult']['token'];
      final SharedPreferences? prefs = await _prefs;
      await prefs?.setString('token', token);

      emailController.clear();
      passwordController.clear();

      return true;
    } else {
      final data = jsonDecode(responsee.body);
      print(data['message']);
      return false;
    }
  }
}
