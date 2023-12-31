import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TodoController extends GetxController {

  RxString loading = 'Loading Please Wait...'.obs;


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
      var response = await http.post(Uri.parse(registration),
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
      Get.snackbar("ToDo NodeJS + MongoDb", 'Please Enter Valid Value',
          backgroundColor: Colors.blue, colorText: Colors.white);
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
    if (txtLoginEmail.value.text.isNotEmpty &&
        txtLoginPassword.value.text.isNotEmpty) {
      var loginBody = {
        "email": txtLoginEmail.value.text,
        "password": txtLoginPassword.value.text,
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
    } else {
      isLoginnotValid.value = true;
      Get.snackbar("ToDo NodeJS + MongoDb", 'Please Enter Valid Value',
          backgroundColor: Colors.blue, colorText: Colors.white);
    }
  }

  // Add Todo Logic ============================================

  Rx<TextEditingController> todoTxtTitle = TextEditingController().obs;
  Rx<TextEditingController> totoTxtDesc = TextEditingController().obs;

  late String userId;

  void addTodo() async {
    if (todoTxtTitle.value.text.isNotEmpty &&
        totoTxtDesc.value.text.isNotEmpty) {
      var addTodoBody = {
        "userId": userId,
        "title": todoTxtTitle.value.text,
        "desc": totoTxtDesc.value.text,
      };
      var response = await http.post(Uri.parse(storeTodo),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(addTodoBody));
      // ignore: avoid_print
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        Get.snackbar("ToDo NodeJS + MongoDb", 'Create Todo Successfully',
            backgroundColor: Colors.blue, colorText: Colors.white);
        todoTxtTitle.value.clear();
        totoTxtDesc.value.clear();
        getTodoList(userId);
      } else {
        Get.snackbar("ToDo NodeJS + MongoDb", 'Something Went Wrong',
            backgroundColor: Colors.blue, colorText: Colors.white);
      }
    } else {
      isnotValid.value = true;
      Get.snackbar("ToDo NodeJS + MongoDb", 'Please Enter Valid Todo',
          backgroundColor: Colors.blue, colorText: Colors.white);
    }
  }

  // List View ================================================

  RxList<Map>? items;

  Future<RxList<Map>?> getTodoList(String uID) async {
    var getTodoBody = {
      "userId": uID,
    };
    var response = await http.post(Uri.parse(getToDoList),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(getTodoBody));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      // Check if jsonResponse is a List
      if (jsonResponse['success'] is List) {
        // Assign directly to items
        items = RxList<Map>.from(jsonResponse['success']);
        print(items?.length);
      } else {
        Get.snackbar("ToDo NodeJS + MongoDb", 'Invalid response format',
          backgroundColor: Colors.blue, colorText: Colors.white);
      }
    } else {
      Get.snackbar("ToDo NodeJS + MongoDb", 'Somrthing Wrong',
          backgroundColor: Colors.blue, colorText: Colors.white);
    }
    return items;
   }



  // Delete Todo ================================================

  Future<void> deleteToDo (id)
  async {
    print(id);
    var loginBody = {
        "id": id,
      };

      var response = await http.post(Uri.parse(deleteTodo),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(loginBody));

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['success']==true) {
         getTodoList(userId);
      }

     
  }

}
