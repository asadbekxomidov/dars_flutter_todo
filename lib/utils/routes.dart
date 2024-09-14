// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:main/utils/routnames.dart';
import 'package:main/views/screens/card_sceen.dart';
import 'package:main/views/screens/course_screen.dart';
import 'package:main/views/screens/favorite_screens.dart';
import 'package:main/views/screens/home_screen.dart';
import 'package:main/views/screens/lesson_screen.dart';
import 'package:main/views/screens/login_screen.dart';
import 'package:main/views/screens/note_screen.dart';
import 'package:main/views/screens/quiz_screen.dart';
import 'package:main/views/screens/settings_screen.dart';
import 'package:main/views/screens/todo_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    RouteNames.homeRoute: (ctx) => const HomeScreen(),
    RouteNames.settingsRoute: (ctx) => const SettingsScreen(),
    RouteNames.todoRoute: (ctx) => const TodoAppScreens(),
    RouteNames.noteRoute: (ctx) => const NotesScreens(),
    RouteNames.courseRoute: (ctx) => const CourseListScreen(),
    RouteNames.lessonRoute: (ctx) => const LessonListScreen(),
    RouteNames.quizRoute: (ctx) => const QuizScreen(),
    RouteNames.loginRoute: (ctx) => const LoginScreen(),
    RouteNames.favoriteRoute: (ctx) =>  FavoriteScreen(),
    RouteNames.cardRoute: (ctx) =>  CartScreen(),
  };
}
