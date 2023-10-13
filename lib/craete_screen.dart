import 'package:flutter/material.dart';
import 'package:flutter_todo_demo/controller.dart';
import 'package:get/get.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
   TodoController controller = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Obx(
              () =>  TextField(
                controller: controller.txtEmail.value,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  errorText: controller.isnotValid.value?"Enter Value":null,
                    labelText: 'Email',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
      
            const SizedBox(height: 10),
      
            // Password TextField
            Obx(
              () =>  TextField(
                controller: controller.txtPassword.value,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  errorText: controller.isnotValid.value?"Enter Value":null,
                    labelText: 'Password',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
                obscureText: true,
              ),
            ),
      
            const SizedBox(height: 20),
      
            // Register Button
            ElevatedButton(
              onPressed: () {
                // Handle registration logic
                controller.register();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child:
                  const Text('Register', style: TextStyle(color: Colors.white)),
            ),
      
            const SizedBox(height: 10),
      
            // Already have an account? Sign In TextButton
            TextButton(
              onPressed: () {
                // Navigate to Sign In screen
                
                Get.toNamed('/login');
              },
              child: const Text(
                'Already have an account? Sign In',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}