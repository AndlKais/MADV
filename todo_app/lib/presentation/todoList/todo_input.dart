import 'package:flutter/material.dart';
import 'package:todo_app/infrastructure/todoItem_repository.dart';
import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:todo_app/presentation/todoHomepage/todo_homepage_controller.dart';

class TodoInput extends StatefulWidget {

  final List<TodoItem> todoItems;
  final Function(List<TodoItem>) onTodoItemsUpdated;
  const TodoInput({super.key, required this.todoItems, required this.onTodoItemsUpdated});

  @override
  State<StatefulWidget> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final myController = TextEditingController();
  late final TodoItemRepository todoItemRepository;


  @override
  void initState() {

    super.initState();
    todoItemRepository = TodoItemRepository();
  }


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
              name: myController.text,
              done: true,
              id: 0,
            );
            setState(() {
              widget.todoItems.add(newTodoItem);
              todoItemRepository.addTodoItem(newTodoItem);
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