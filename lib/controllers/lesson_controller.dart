import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main/models/lesson.dart';


class LessonController {
  final String baseUrl = 'https://dars6-b0f9a-default-rtdb.firebaseio.com/lessons.json';

  Future<void> addLesson(Lesson lesson) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode(lesson.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add lesson');
    }
  }

  Future<List<Lesson>> fetchLessons() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to load lessons');
    }

    final data = json.decode(response.body) as Map<String, dynamic>? ?? {};
    List<Lesson> lessons = [];

    data.forEach((lessonId, lessonData) {
      lessonData['id'] = lessonId;
      Lesson lesson = Lesson.fromJson(lessonData);
      lessons.add(lesson);
    });

    return lessons;
  }

  Future<void> updateLesson(String id, Lesson lesson) async {
    final response = await http.patch(
      Uri.parse('https://dars6-b0f9a-default-rtdb.firebaseio.com/lessons/$id.json'),
      body: json.encode(lesson.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update lesson');
    }
  }

  Future<void> deleteLesson(String id) async {
    final response = await http.delete(Uri.parse('https://dars6-b0f9a-default-rtdb.firebaseio.com/lessons/$id.json'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete lesson');
    }
  }
}
