import 'package:flutter/material.dart';
import 'package:flutter_todo_demo/craete_screen.dart';
import 'package:flutter_todo_demo/home_screen.dart';
import 'package:flutter_todo_demo/login_screen.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()
async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    initialRoute: '/',
    routes: {
      '/':(p0) => const CreateScreen(),
      '/login':(p0) => const LoginScreen(),
      '/home':(p0) => HomeScreen(token: prefs.getString('token')),
    },
  ));
}