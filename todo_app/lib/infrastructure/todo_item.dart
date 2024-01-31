class TodoItem{
  int id;
  bool done;
  String name;

  TodoItem({required this.id, required this.done, required this.name});

  factory TodoItem.fromJson(Map<String, dynamic> json) {

    print(json['id']);

    return TodoItem(
      id: json['id'],
      done: json['done'],
      name: json['name']
    );
  }
}