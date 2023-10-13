import 'dart:convert';
import 'config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TodoController extends GetxController {
  Rx<TextEditingController> txtEmail = TextEditingController().obs;
  Rx<TextEditingController> txtPassword = TextEditingController().obs;

  RxBool isnotValid = false.obs;

  void register() async {
    if (txtEmail.value.text.isNotEmpty && txtPassword.value.text.isNotEmpty) {
      var registerBody = {
        "email": txtEmail.value.text,
        "password": txtPassword.value.text,
      };
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(registerBody));
      // ignore: avoid_print
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        Get.offAndToNamed('/login');
      } else {
        print('Something Went Wrong');
      }
    } else {
      isnotValid.value = true;
    }
  }
}
