import 'package:flutter/foundation.dart';
import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItemRepository {
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TodoItem>> getAllTodoItems() async {
    final todoItemsCollection = await _firestore.collection('todoItems').get();

    for (QueryDocumentSnapshot documentSnapshot in todoItemsCollection.docs) {
      if (kDebugMode) {
        print(documentSnapshot.data());
      }
    }

    final todoItemList =
        todoItemsCollection.docs.map((e) => TodoItem.fromJson(e)).toList();

    return Future.value(todoItemList);

    /*
    String jsonFile = await rootBundle.loadString('assets/todo-item.json');
    final jsonArray = json.decode(jsonFile) as Iterable;

    List<TodoItem> todoItems = List<TodoItem>.from(
        jsonArray.map((e) => TodoItem.fromJson(e)));

    return Future.value(todoItems);
     */
  }

  Future<void> addTodoItem(TodoItem todoItem) async {
    try {
      await _firestore.collection('todoItems').add(
          {'id': todoItem.id, 'done': todoItem.done, 'name': todoItem.name});
      print('Daten erfolgreich in Firestore gespeichert.');
    } catch (e) {
      print('Fehler beim Speichern der Daten: $e');
    }
  }

  Future<void> deleteDataBasedOnQuery(TodoItem todoItem) async {
    print("field: $todoItem.id");

    try {
      await _firestore.collection('todoItems').doc(todoItem.id).delete();
      print('Daten erfolgreich aus Firestore gelöscht.');
    } catch (e) {
      print('Fehler beim Löschen der Daten: $e');
    }
  }

  Future<void> updateDataBasedOnQuery(String name, bool done, String id) async {
    try {
      await _firestore
          .collection('todoItems')
          .doc(id)
          .update({'id': id, 'done': done, 'name': name});
      print('Daten erfolgreich in Firestore aktualisiert.');
    } catch (e) {
      print('Fehler beim Aktualisieren der Daten: $e');
    }
  }
}
