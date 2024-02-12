import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:todo_app/presentation/login/login.dart';
import 'package:todo_app/presentation/todoHomepage/todo_login_controller.dart';

class TodoLogin extends GetView<TodoLoginController> {

  final String title;

  const TodoLogin({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("ToDo-List App"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Login()
            ],
        ),
      )

    );
  }
}