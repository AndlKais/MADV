import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItemRepository {
  Future<List<TodoItem>> getAllTodoItems() async {
    final todoItemsCollection =
        await FirebaseFirestore.instance.collection('todoItems').get();

    if (kDebugMode) {
      print("komme bis hier hin");
    }


    for (QueryDocumentSnapshot documentSnapshot in todoItemsCollection.docs) {
      if (kDebugMode) {
        print(documentSnapshot.data());
      }
    }

    final todoItemList = todoItemsCollection.docs
        .map((e) =>
            TodoItem.fromJson(jsonEncode(e.data()) as Map<String, dynamic>))
        .toList();
    return todoItemList;

    /*String jsonFile = await rootBundle.loadString('assets/todo-item.json');
      final jsonArray = json.decode(jsonFile) as Iterable;

      List<TodoItem> todoItems = List<TodoItem>.from(
        jsonArray.map((e) => TodoItem.fromJson(e)));

      return Future.value(todoItems);

      List<TodoItem> todoItems = List<TodoItem>.from(jsonArray.map((e) => TodoItem.fromJson(e)));
    */
  }
}
