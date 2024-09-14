import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main/models/quiz.dart';


class QuizController {
  final String baseUrl = 'https://dars6-b0f9a-default-rtdb.firebaseio.com/';

  Future<List<Quiz>> fetchQuizzes() async {
    final response = await http.get(Uri.parse('${baseUrl}test.json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data.entries.map((entry) => Quiz.fromJson(data)).toList();
      // return data.entries.map((entry) => Quiz.fromJson(entry.key, entry.value)).toList();
    } else {
      throw Exception('Failed to load quizzes');
    }
  }

  Future<void> addQuiz(Quiz quiz) async {
    final response = await http.post(
      Uri.parse('${baseUrl}test.json'),
      body: json.encode(quiz.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add quiz');
    }
  }

  Future<void> editQuiz(String id, Quiz quiz) async {
    final response = await http.patch(
      Uri.parse('${baseUrl}test/$id.json'),
      body: json.encode(quiz.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to edit quiz');
    }
  }

  Future<void> deleteQuiz(String id) async {
    final response = await http.delete(Uri.parse('${baseUrl}test/$id.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete quiz');
    }
  }

  bool checkAnswer(Quiz quiz, int selectedOptionIndex) {
    return selectedOptionIndex == quiz.correctOptionIndex;
  }
}
