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
      todoItemRepository.getAllTodoItems().then((todoItems) {
        if (kDebugMode) {
          print("Abgerufene TodoItems: $todoItems");
        }
        if (todoItems.isNotEmpty) {
          initialTodoItems.clear();
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
    print("todoItem.done 1: " + todoItem.done.toString());
    if(!todoItem.done){
      print("todoItem.done 2: " + todoItem.done.toString());
      Icons.check_box;
      todoItem.done = true;
      print("todoItem.done 3: " + todoItem.done.toString());
      todoItemRepository.updateDataBasedOnQuery(todoItem.name, todoItem.done, todoItem.id);
      update();
    }else{
      Icons.check_box_outline_blank;
      todoItem.done = false;
      print("todoItem.done 4: " + todoItem.done.toString());
      todoItemRepository.updateDataBasedOnQuery(todoItem.name, todoItem.done, todoItem.id);
      update();
    }
  }
}
