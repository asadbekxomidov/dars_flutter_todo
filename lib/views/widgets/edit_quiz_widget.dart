// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:main/controllers/quiz_controller.dart';
import 'package:main/models/quiz.dart';

class EditQuizScreen extends StatefulWidget {
  final Quiz quiz;

  EditQuizScreen({required this.quiz});

  @override
  _EditQuizScreenState createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
  final QuizController controller = QuizController();
  late TextEditingController questionController;
  late List<TextEditingController> optionControllers;
  late int correctOptionIndex;

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController(text: widget.quiz.question);
    optionControllers = widget.quiz.options
        .map((option) => TextEditingController(text: option))
        .toList();
    correctOptionIndex = widget.quiz.correctOptionIndex;
  }

  void editQuiz() {
    Quiz updatedQuiz = Quiz(
      id: widget.quiz.id,
      question: questionController.text,
      options: optionControllers.map((controller) => controller.text).toList(),
      correctOptionIndex: correctOptionIndex,
    );
    controller.editQuiz(widget.quiz.id, updatedQuiz).then((_) {
      Navigator.pop(context, true);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to edit quiz',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            const SizedBox(height: 10),
            ...optionControllers.asMap().entries.map((entry) {
              int index = entry.key;
              TextEditingController controller = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Option ${index + 1}',
                  ),
                ),
              );
            }).toList(),
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
              hint: const Text('Select Correct Option'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: editQuiz,
              child: const Text('Edit Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
