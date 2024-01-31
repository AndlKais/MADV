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
    todoItemRepository.getAllTodoItems().then((todoItems) {
      print("Abgerufene TodoItems: $todoItems");
      if (todoItems.isNotEmpty) {
        initialTodoItems.addAll(todoItems);
      } else {
        print("Keine Daten gefunden");
      }
    }).catchError((error) {
      print("Fehler beim Abrufen der Daten: $error");
    });
  }

  void editTodoItem(TodoItem todoItem) {
    todoItemRepository.updateDataBasedOnQuery('name', 'test', 'testerchen');

    String editedValue =
        initialTodoItems[initialTodoItems.indexOf(todoItem)].name;

    TextEditingController editingController =
        TextEditingController(text: editedValue);

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
          initialTodoItems[initialTodoItems.indexOf(todoItem)].name =
              editedValue;
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
    todoItemRepository.deleteDataBasedOnQuery('name', 'testerchen');
  }
}
