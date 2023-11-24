import 'package:flutter/material.dart';
import 'package:todo_app/infrastructure/todoItem_repository.dart';
import 'package:todo_app/presentation/todoHomepage/todo_homepage_controller.dart';
import 'todoHomepage/todo_homepage.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TodoHomepageController());
    Get.lazyPut(() => TodoItemRepository());

    return MaterialApp(
      title: 'ToDo-List',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0x94A0EAFF),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TodoHomepage(title: 'ToDo-App'),
      debugShowCheckedModeBanner: false,
    );
  }
}