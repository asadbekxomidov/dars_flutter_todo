// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main/models/course.dart';


class CourseController {
  final String baseUrl = 'https://dars6-b0f9a-default-rtdb.firebaseio.com/kurs.json';

  Future<void> addCourse(Course course) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode(course.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add course');
    }
  }

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to load courses');
    }

    final data = json.decode(response.body) as Map<String, dynamic>? ?? {};
    List<Course> courses = [];

    data.forEach((courseId, courseData) {
      courseData['id'] = courseId;
      Course course = Course.fromJson(courseData);
      courses.add(course);
    });

    print("Fetched Courses: $courses");

    return courses;
  }

  Future<void> updateCourse(String id, Course course) async {
    final response = await http.patch(
      Uri.parse('https://dars6-b0f9a-default-rtdb.firebaseio.com/kurs/$id.json'),
      body: json.encode(course.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update course');
    }
  }

  Future<void> deleteCourse(String id) async {
    final response = await http.delete(Uri.parse('https://dars6-b0f9a-default-rtdb.firebaseio.com/kurs/$id.json'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete course');
    }
  }
}
