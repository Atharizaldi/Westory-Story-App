import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final String _baseUrl = 'https://story-api.dicoding.dev/v1/';

  Future<bool> registration() async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse("${_baseUrl}register");

    Map body = {
      'name': nameController.text,
      'email': emailController.text.trim(),
      'password': passwordController.text
    };

    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);

    if (response.statusCode == 201) {
      nameController.clear();
      emailController.clear();
      passwordController.clear();

      return true;
    } else {
      return false;
    }
  }
}
