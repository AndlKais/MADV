import 'package:flutter/foundation.dart';
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
    _initData();
    super.onInit();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _initData() {
    if (initialTodoItems.isEmpty) {
      todoItemRepository.getAllTodoItems().then((todoItems) {
        if (kDebugMode) {
          print("Abgerufene TodoItems: $todoItems");
        }
        if (todoItems.isNotEmpty) {
          initialTodoItems.addAll(todoItems);
          update();
        } else {
          if (kDebugMode) {
            print("Keine Daten gefunden");
          }
        }
      }).catchError((error) {
        if (kDebugMode) {
          print("Fehler beim Abrufen der Daten: $error");
        }
      });
    }
  }

  void addTodoItem(TodoItem newTodoItem){
    todoItemRepository.addTodoItem(newTodoItem).then((_) {
      initialTodoItems.add(newTodoItem);
      update();
    });
  }

  void editTodoItem(String name, bool done, String id) {
    todoItemRepository.updateDataBasedOnQuery(name, done, id);
    update();
  }

  void deleteTodoItem(TodoItem todoItem) {
    initialTodoItems.remove(todoItem);
    todoItemRepository.deleteDataBasedOnQuery(todoItem);
  }

  void toggleDone(TodoItem todoItem) {
    todoItem.done = !todoItem.done;
    update();
    if(todoItem.done){
      Icons.check_box;
      deleteTodoItem(todoItem);
    }else {
      todoItemRepository.updateDataBasedOnQuery(
          todoItem.name, todoItem.done, todoItem.id);
      update();
    }
  }
}
