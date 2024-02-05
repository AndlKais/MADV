import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItem{
  String id;
  bool done;
  String name;

  TodoItem({required this.id, this.done = false, required this.name});

  /*factory TodoItem.fromJson(Map<String, dynamic> json) {

    return TodoItem(
      id: json['id'],
      done: json['done'],
      name: json['name']
    );
  }*/

  factory TodoItem.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    return TodoItem(
        id: doc.id,
        done: json['done'],
        name: json['name']
    );
  }
}