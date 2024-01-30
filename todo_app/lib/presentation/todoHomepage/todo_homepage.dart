import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/presentation/todoItem/new_todo_item.dart';
import 'package:todo_app/presentation/todoList/todo_input.dart';
import 'package:todo_app/presentation/todoHomepage/todo_homepage_controller.dart';

class TodoHomepage extends GetView<TodoHomepageController> {


  TodoHomepage({super.key});

  //final todoItemRepository = TodoItemRepository();

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
                onTodoItemsUpdated: (updatedTodoItems) {}
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
              Obx(() => ListView.builder(
                  itemBuilder: (context, index) {
                      return NewTodoItem(
                          newTodoItem: controller.initialTodoItems[index],
                          onTap: (todoItem){
                            controller.editTodoItem(controller.initialTodoItems[index]);

                          },
                          /*onPressed: (todoItem) {
                            todoItem = controller.initialTodoItems[index];
                            print(todoItem.categoryName);
                            print("Logged!");
                            controller.editTodoItem(todoItem);
                          }*/
                      );
                    },
                  itemCount: controller.initialTodoItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
