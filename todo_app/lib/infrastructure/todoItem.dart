class TodoItem{
  String title;
  String categoryName;
  String finishDate;

  TodoItem({required this.title, required this.categoryName, required this.finishDate});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(title: json['title'],
        categoryName: json['categoryName'],
        finishDate: json['finishDate']
    );
  }
}