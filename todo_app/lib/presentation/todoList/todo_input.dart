import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:todo_app/presentation/todoHomepage/todo_homepage_controller.dart';

class TodoInput extends StatelessWidget {

  /*final List<TodoItem> todoItems;
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
              id: DateTime.now().toString()
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
  }*/

  final List<TodoItem> todoItems;
  final Function(List<TodoItem>) onTodoItemsUpdated;
  TodoInput({super.key, required this.todoItems, required this.onTodoItemsUpdated});

  final TodoHomepageController todoController = Get.find();
  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                hintText: 'Enter Your ToDo',
              ),
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
              done: false,
              id: DateTime.now().toString(),
            );
            todoController.addTodoItem(newTodoItem);
            myController.clear();
          },
          child: const Text("Add ToDo"),
        )
      ],
    );
  }
}