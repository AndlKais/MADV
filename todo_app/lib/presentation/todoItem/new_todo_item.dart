import 'dart:developer';

import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/presentation/todoHomepage/todo_homepage_controller.dart';

class NewTodoItem extends GetView<TodoHomepageController> {


  final TodoItem newTodoItem;
  final Function(TodoItem) onTap;

  const NewTodoItem({super.key, required this.newTodoItem, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () => onTap(newTodoItem),
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
              Text(newTodoItem.name),
              /*Text(
                'Finish Date: ${newTodoItem.finishDate}',
                style: const TextStyle(color: Colors.black),
              ),*/
              IconButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context, newTodoItem);
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


  void _showDeleteConfirmationDialog(BuildContext context, TodoItem todoItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Todo Item'),
          content: Text('Are you sure you want to delete this todo item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.deleteTodoItem(todoItem);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }




  /*



  final TodoItem newTodoItem;
  final Function(TodoItem) onPressed;

  const NewTodoItem({super.key, required this.newTodoItem, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () {
          print(newTodoItem.categoryName);

          onPressed(this.newTodoItem);
          /*if (newTodoItem != null) {
            inspect(newTodoItem);
            onPressed(this.newTodoItem);
          } else {
            // newTodoItem ist null, zeige eine Warnung oder führe alternative Logik aus
            print("Warning: newTodoItem is null");
          }*/
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
                  //controller.deleteTodoItem(newTodoItem);
                },
                icon: const Icon(Icons.delete),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
