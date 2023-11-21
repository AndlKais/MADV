import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:todo_app/infrastructure/todoItem.dart';

class TodoItemRepository{
  Future<List<TodoItem>> fillList() async{
    String jsonFile = await rootBundle.loadString('assets/todo-item.json');
    final jsonArray = json.decode(jsonFile) as Iterable;

    List<TodoItem> todoItems = List<TodoItem>.from(jsonArray.map((e) => TodoItem.fromJson(e)));
    return Future.value(todoItems);
  }
}