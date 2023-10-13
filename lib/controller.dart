import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TodoController extends GetxController {
  // register user Logic ============================================

  Rx<TextEditingController> txtEmail = TextEditingController().obs;
  Rx<TextEditingController> txtPassword = TextEditingController().obs;

  RxBool isnotValid = false.obs;

  void register() async {
    if (txtEmail.value.text.isNotEmpty && txtPassword.value.text.isNotEmpty) {
      var registerBody = {
        "email": txtEmail.value.text,
        "password": txtPassword.value.text,
      };
      var response =await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(registerBody));
      // ignore: avoid_print
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        Get.snackbar("ToDo NodeJS + MongoDb", 'Create Account Successfully',
            backgroundColor: Colors.blue, colorText: Colors.white);
        Get.offAndToNamed('/login');
      } else {
        Get.snackbar("ToDo NodeJS + MongoDb", 'Something Went Wrong',
            backgroundColor: Colors.blue, colorText: Colors.white);
      }
    } else {
      isnotValid.value = true;
    }
  }

  // Login user Logic ============================================

  Rx<TextEditingController> txtLoginEmail = TextEditingController().obs;
  Rx<TextEditingController> txtLoginPassword = TextEditingController().obs;

  RxBool isLoginnotValid = false.obs;

  late SharedPreferences prefs;

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (txtEmail.value.text.isNotEmpty && txtPassword.value.text.isNotEmpty) {
      var loginBody = {
        "email": txtEmail.value.text,
        "password": txtPassword.value.text,
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(loginBody));

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        Get.snackbar("ToDo NodeJS + MongoDb", 'Login Successfully',
            backgroundColor: Colors.blue, colorText: Colors.white);
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        
        Get.offAndToNamed('/home', arguments: myToken);
      } else {
        Get.snackbar("ToDo NodeJS + MongoDb", 'Something Went W̥̥rong',
            backgroundColor: Colors.blue, colorText: Colors.white);
      }
    }
  }
}
