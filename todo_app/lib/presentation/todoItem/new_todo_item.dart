import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/presentation/todoHomepage/todo_homepage_controller.dart';

class NewTodoItem extends GetView<TodoHomepageController> {
  final TodoItem newTodoItem;
  final Function(TodoItem)? onPressed;

  const NewTodoItem({super.key, required this.newTodoItem, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () {
          if (onPressed != null) {
            onPressed!(newTodoItem);
          }
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                newTodoItem.title,
              ),
              Text(
                'Finish Date: ${newTodoItem.finishDate}',
                style: const TextStyle(color: Colors.black),
              ),
              IconButton(
                onPressed: () {
                  controller.deleteTodoItem(newTodoItem);
                },
                icon: const Icon(Icons.delete),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
