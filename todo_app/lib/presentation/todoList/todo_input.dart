import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/infrastructure/todo_item.dart';

class TodoInput extends StatefulWidget {
  List<TodoItem> todoItems;
  final Function(List<TodoItem>) onTodoItemsUpdated;
  TodoInput({super.key, required this.todoItems, required this.onTodoItemsUpdated});

  @override
  State<StatefulWidget> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final myController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return
    Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            'Please enter your ToDo: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: 500,
            child: TextField(
              controller: myController,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ToDo:',
                  hintText: 'Enter Your ToDo'),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            final newTodoItem = TodoItem(
              title: myController.text,
              categoryName: "Default",
              finishDate: '',
            );
            inspect(newTodoItem);
            setState(() {
              widget.todoItems.add(newTodoItem);
              myController.clear();
              widget.onTodoItemsUpdated(widget.todoItems);
            });
          },
          child: const Text("Add ToDo"),
        )
      ],
    );
  }
}