import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:flutter/material.dart';

class InitialTodoItem extends StatelessWidget {
  final TodoItem todoItem;

  const InitialTodoItem({super.key, required this.todoItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(todoItem.title)
    );
  }
}
