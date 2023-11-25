import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:todo_app/infrastructure/todoItem_repository.dart';

class TodoHomepageController extends GetxController {
  var todoItemRepository = Get.find<TodoItemRepository>();
  var initialTodoItems = <TodoItem>[].obs;

  var myController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _initData() {
    todoItemRepository
        .fillList()
        .then((todoItems) => initialTodoItems.addAll(todoItems));
  }

  void editTodoItem(TodoItem todoItem) {
    String editedValue =
        initialTodoItems[initialTodoItems.indexOf(todoItem)].title;

    Get.dialog(
      AlertDialog(
        title: const Text('Edit ToDo-Item'),
        content: TextField(
          controller: TextEditingController(
              text: initialTodoItems[initialTodoItems.indexOf(todoItem)].title),
          autofocus: true,
          onChanged: (newValue) {
            editedValue = newValue;
          },
          onSubmitted: (newValue) {
            initialTodoItems[initialTodoItems.indexOf(todoItem)].title =
                newValue;
            Get.back(result: newValue);
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: editedValue);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ).then((returnVal) {
      if (returnVal != null) {
        initialTodoItems[initialTodoItems.indexOf(todoItem)].title = returnVal;
      }
    });
  }

  void deleteTodoItem(TodoItem todoItem) {
    var todoItemsList = List<TodoItem>.from(initialTodoItems);

    Get.dialog(
      AlertDialog(
        title: const Text('Delete ToDo-Item'),
        content: const Text('Are you sure you want to delete this ToDo Item?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              initialTodoItems.remove(todoItem);
              initialTodoItems.assignAll(todoItemsList);
              Get.back();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
