class TodoApp {
  String title;
  String description;
  bool isCompleted;

  TodoApp({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  factory TodoApp.fromJson(Map<String, dynamic> json) {
    return TodoApp(
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}
