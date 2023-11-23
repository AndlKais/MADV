import 'package:flutter/material.dart';
import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:todo_app/infrastructure/todoItem_repository.dart';
import 'package:todo_app/presentation/todoItem/new_todo_item.dart';
import 'package:todo_app/presentation/todoList/todo_input.dart';
import '../todoItem/initial_todo_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  final todoItemRepository = TodoItemRepository();
  List<TodoItem> _todoItems = [];

  //List<TodoItem> _availableTodoItems = [];

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    todoItemRepository
        .fillList()
        .then((todoItems) => setState(() => _todoItems = todoItems));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.title),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TodoInput(
                todoItems: _todoItems,
                onTodoItemsUpdated: (updatedTodoItems) {
                  setState(() {
                    _todoItems = updatedTodoItems;
                  });
                }),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return NewTodoItem(
                      newTodoItem: _todoItems[index],
                      onPressed: (todoItem) {
                        if (todoItem.origin == TodoItemOrigin.New) {
                          _editTodoItem(index);
                        }
                      });

                  //_createTodo(index);
                },
                itemCount: _todoItems.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  //test

  void _editTodoItem(int index) {
    String editedValue = _todoItems[index].title;

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit ToDo-Item'),
          content: TextField(
            controller: TextEditingController(text: _todoItems[index].title),
            autofocus: true,
            onChanged: (newValue) {
              editedValue = newValue;
            },
            onSubmitted: (newValue) {
              setState(
                () {
                  _todoItems[index].title = newValue;
                },
              );
              Navigator.of(context).pop(newValue);
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(editedValue);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((returnVal) {
      if (returnVal != null) {
        setState(() {
          _todoItems[index].title = returnVal;
        });
      }
    });
  }

  void _deleteTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete ToDo-Item'),
          content:
              const Text('Are you sure you want to delete this ToDo Item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _todoItems.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
