import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:todo_app/infrastructure/todoItem_repository.dart';

class TodoHomepageController extends GetxController {
  var todoItemRepository = Get.find<TodoItemRepository>();
  List<TodoItem> initialTodoItems = <TodoItem>[].obs;

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
    print("initialisieren");
    todoItemRepository
        .getAllTodoItems()
        .then((todoItems) => initialTodoItems.addAll(todoItems));
  }

  void editTodoItem(TodoItem todoItem) {
    print("bin in editTodoItem");
    String editedValue = initialTodoItems[initialTodoItems.indexOf(todoItem)]
        .name;

    TextEditingController editingController = TextEditingController(
        text: editedValue);

    print(editedValue);



    Get.defaultDialog(
      title: 'Edit ToDo-Item',
      content: TextField(
        controller: editingController,
        autofocus: true,
        onChanged: (newValue) {
          editedValue = newValue;
        },
      ),
      confirm: ElevatedButton(
        onPressed: () {
          initialTodoItems[initialTodoItems.indexOf(todoItem)].name = editedValue;
          Get.back();
        },
        child: const Text('Save'),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Cancel'),
      ),
    ).then((returnVal) {
      if (returnVal != null) {
        initialTodoItems[initialTodoItems.indexOf(todoItem)].name = returnVal;
      }
    });
  }



/*Get.defaultDialog(
          title: 'Dialog',
          content: Text('This is a dialog'),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Get.back(),
            ),
          ],

      );

  }




  void editTodoItem(TodoItem todoItem) {
    String editedValue =
        initialTodoItems[initialTodoItems.indexOf(todoItem)].title;

    print("Komme hier hin" + editedValue);

    Get.dialog(

    );
  }*/

  void deleteTodoItem(TodoItem todoItem) {

    initialTodoItems.remove(todoItem);

    /*
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
    );*/
  }
}
