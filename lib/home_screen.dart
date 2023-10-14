import 'package:flutter/material.dart';
import 'package:flutter_todo_demo/controller.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const HomeScreen({@required this.token, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoController controller = Get.put(TodoController());
  
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    controller.userId = jwtDecodedToken['_id'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Save Your Todo',
            style: TextStyle(letterSpacing: 1, color: Colors.black),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    "Create Todo",
                    style: TextStyle(letterSpacing: 1, color: Colors.black),
                  ),
                  actions: [
                    TextField(
                      controller: controller.todoTxtTitle.value,
                      cursorColor: Colors.blue,
                      decoration: const InputDecoration(
                          labelText: 'Title',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controller.totoTxtDesc.value,
                      cursorColor: Colors.blue,
                      decoration: const InputDecoration(
                          labelText: 'Description',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        controller.addTodo();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                            letterSpacing: 1, color: Colors.white),
                      ),
                    )
                  ],
                );
              },
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [FlutterLogo(size: 150,)],
          ),
        ),
      ),
    );
  }
}
