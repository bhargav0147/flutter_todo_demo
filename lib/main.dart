import 'package:flutter/material.dart';
import 'package:flutter_todo_demo/craete_screen.dart';
import 'package:flutter_todo_demo/login_screen.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    routes: {
      '/': (p0) => const CreateAccountScreen(),
      '/login':(p0) => const LoginScreen()
    },
  ));
}
