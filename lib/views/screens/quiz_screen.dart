// ignore_for_file: library_private_types_in_public_api, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:main/controllers/quiz_controller.dart';
import 'package:main/models/quiz.dart';
import 'package:main/utils/app_contants.dart';
import 'package:main/views/widgets/add_quiz_widget.dart';
import 'package:main/views/widgets/custom_drawer.dart';
import 'package:main/views/widgets/edit_quiz_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizController controller = QuizController();
  List<Quiz>? quizzes;
  int currentQuizIndex = 0;
  bool? isAnswerCorrect;

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  void fetchQuizzes() async {
    quizzes = await controller.fetchQuizzes();
    setState(() {});
  }

  void submitAnswer(int selectedOptionIndex) {
    if (quizzes != null && quizzes!.isNotEmpty) {
      isAnswerCorrect = controller.checkAnswer(
          quizzes![currentQuizIndex], selectedOptionIndex);
      setState(() {});
    }
  }

  void nextQuiz() {
    if (quizzes != null && currentQuizIndex < quizzes!.length - 1) {
      currentQuizIndex++;
      isAnswerCorrect = null;
      setState(() {});
    }
  }

  void previousQuiz() {
    if (currentQuizIndex > 0) {
      currentQuizIndex--;
      isAnswerCorrect = null;
      setState(() {});
    }
  }

  void deleteQuiz(String id) {
    controller.deleteQuiz(id).then((_) {
      fetchQuizzes();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Failed to delete quiz',
        style: TextStyle(fontSize: 15, color: Colors.red.shade200),
      )));
    });
  }

  void editQuiz(Quiz quiz) async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditQuizScreen(quiz: quiz)),
    );
    if (result == true) {
      fetchQuizzes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appBarColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.quiz,
          style: TextStyle(
            fontSize: AppConstants.appBarTextSize,
            color: AppConstants.appBarTextColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: AppConstants.drawerIconSize,
              color: Colors.white,
            ),
            onPressed: () async {
              bool? result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddQuizScreen()),
              );
              if (result == true) {
                fetchQuizzes();
              }
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: quizzes == null
          ? const Center(child: CircularProgressIndicator())
          : quizzes!.isEmpty
              ? Center(
                  child: Text(
                  'No quizzes available',
                  style: TextStyle(fontSize: 15, color: Colors.red.shade200),
                ))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quizzes![currentQuizIndex].question,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      ...quizzes![currentQuizIndex]
                          .options
                          .asMap()
                          .entries
                          .map((entry) {
                        int idx = entry.key;
                        String option = entry.value;
                        return ListTile(
                          title: Text(option),
                          leading: Radio(
                            value: idx,
                            groupValue: isAnswerCorrect == null
                                ? -1
                                : (isAnswerCorrect! ? idx : -1),
                            onChanged: (value) {
                              submitAnswer(idx);
                            },
                          ),
                        );
                      }).toList(),
                      if (isAnswerCorrect != null)
                        Text(
                          isAnswerCorrect!
                              ? 'Correct!'
                              : 'Incorrect, try again.',
                          style: TextStyle(
                            fontSize: 16,
                            color: isAnswerCorrect! ? Colors.green : Colors.red,
                          ),
                        ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (currentQuizIndex > 0)
                            ElevatedButton(
                              onPressed: previousQuiz,
                              child: const Text(
                                'Previous Question',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ElevatedButton(
                            onPressed: nextQuiz,
                            child: const Text(
                              'Next Question',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              editQuiz(quizzes![currentQuizIndex]);
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              deleteQuiz(quizzes![currentQuizIndex].id);
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}
