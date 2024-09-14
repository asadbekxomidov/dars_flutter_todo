// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:main/controllers/quiz_controller.dart';
import 'package:main/models/quiz.dart';
import 'package:main/utils/app_contants.dart';
import 'package:main/views/widgets/custom_drawer.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  _AddQuizScreenState createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final QuizController controller = QuizController();
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (_) => TextEditingController());
  int correctOptionIndex = 0;

  void addQuiz() {
    Quiz newQuiz = Quiz(
      id: '',
      question: questionController.text,
      options: optionControllers.map((controller) => controller.text).toList(),
      correctOptionIndex: correctOptionIndex,
    );
    controller.addQuiz(newQuiz).then((_) {
      Navigator.pop(context, true);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to add quiz',
            style: TextStyle(fontSize: 15),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appBarColor,
        title: Text(
          'Add Quiz',
          style: TextStyle(
            fontSize: AppConstants.appBarTextSize,
            color: AppConstants.appBarTextColor,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            const SizedBox(height: 10),
            ...List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: optionControllers[index],
                  decoration: InputDecoration(
                    labelText: 'Option ${index + 1}',
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            DropdownButton<int>(
              value: correctOptionIndex,
              items: List.generate(4, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text('Option ${index + 1}'),
                );
              }),
              onChanged: (value) {
                setState(() {
                  correctOptionIndex = value!;
                });
              },
              hint: const Text(
                'Select Correct Option',
                style: TextStyle(fontSize: 16, color: Colors.teal),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addQuiz,
              child: const Text(
                'Add Quiz',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
