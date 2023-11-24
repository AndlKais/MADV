import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:todo_app/infrastructure/todoItem_repository.dart';
import 'package:todo_app/presentation/todoItem/new_todo_item.dart';
import 'package:todo_app/presentation/todoList/todo_input.dart';
import 'package:todo_app/presentation/todoHomepage/todo_homepage_controller.dart';

class TodoHomepage extends GetView<TodoHomepageController> {
  final String title;

  TodoHomepage({super.key, required this.title});

  final todoItemRepository = TodoItemRepository();

  /*@override
  void dispose() {
    myController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("ToDo-List App"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TodoInput(
                todoItems: controller.initialTodoItems,
                onTodoItemsUpdated: (updatedTodoItems) {}),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemBuilder: (context, index) {
                    return NewTodoItem(
                        newTodoItem: controller.initialTodoItems[index],
                        onPressed: (todoItem) {
                          if (todoItem.origin == TodoItemOrigin.New) {
                            controller.editTodoItem(
                                controller.initialTodoItems[index]);
                          }
                        });
                    //_createTodo(index);
                  },
                  itemCount: controller.initialTodoItems.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
