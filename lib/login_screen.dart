import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
     TextEditingController txtEmail = TextEditingController();
    TextEditingController txtPassword = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            const FlutterLogo(
              size: 100,
            ),

            const SizedBox(height: 20),

            // Text
            const Text(
              'Create a new account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Email TextField
            TextField(
              controller: txtEmail,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),

            const SizedBox(height: 10),

            // Password TextField
            TextField(
              controller: txtPassword,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                  labelText: 'Password',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            // Register Button
            ElevatedButton(
              onPressed: () {
                // Handle registration logic
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child:
                  const Text('Sign In', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 10),

            // Already have an account? Sign In TextButton
            TextButton(
              onPressed: () {
                // Navigate to Sign In screen
                Get.back();
              },
              child: const Text(
                'Create New Account',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
