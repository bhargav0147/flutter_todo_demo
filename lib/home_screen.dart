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
            backgroundColor: Colors.blue,
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu_open_rounded,
                  color: Colors.white,
                  size: 30,
                )),
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
                          style:
                              TextStyle(letterSpacing: 1, color: Colors.white),
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
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ToDo with NodeJS + MongoDB",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Total Task",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 580,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child:  FutureBuilder(
                          future: controller.getTodoList(controller.userId),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Icon(Icons.error,color: Colors.red,),);
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                        '${controller.items![index]['title']}'),
                                    trailing: IconButton(
                                        onPressed: () {

                                          
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 20,
                                        )),
                                    leading: const Icon(
                                      Icons.note_alt_outlined,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    subtitle: Text(
                                        '${controller.items![index]['desc']}'),
                                  );
                                },
                                itemCount: controller.items!.length,
                              );
                            }
                            return Center(
                              child: Text(
                                controller.loading.value,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 25),
                              ),
                            );
                          },
                        ),
                      )),
                ),
            
            ],
          )),
    );
  }
}
