import 'package:main/models/lesson.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<Lesson> lessons;
  final double price;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.lessons,
    required this.price,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    var lessonList = json['lessons'] as List? ?? [];
    List<Lesson> lessonsList = lessonList.map((i) => Lesson.fromJson(i)).toList();

    return Course(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      lessons: lessonsList,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'lessons': lessons.map((e) => e.toJson()).toList(),
      'price': price,
    };
  }
}
