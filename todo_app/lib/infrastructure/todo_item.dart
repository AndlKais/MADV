enum TodoItemOrigin {
  initialItem,
  newItem,
}

class TodoItem{
  String title;
  String categoryName;
  String finishDate;
  TodoItemOrigin origin;

  TodoItem({required this.title, required this.categoryName, required this.finishDate,
  this.origin = TodoItemOrigin.newItem
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'],
      categoryName: json['categoryName'],
      finishDate: json['finishDate']
    );
  }
}