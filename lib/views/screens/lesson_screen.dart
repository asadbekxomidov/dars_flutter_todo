// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:main/controllers/lesson_controller.dart';
import 'package:main/models/lesson.dart';
import 'package:main/utils/app_contants.dart';
import 'package:main/views/widgets/add_lesson.dart';
import 'package:main/views/widgets/custom_drawer.dart';
import 'package:main/views/widgets/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LessonListScreen extends StatefulWidget {
  const LessonListScreen({super.key});

  @override
  _LessonListScreenState createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  final LessonController _lessonController = LessonController();
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appBarColor,
        title: Text(
          AppLocalizations.of(context)!.lesson,
          style: TextStyle(
            fontSize: AppConstants.appBarTextSize,
            color: AppConstants.appBarTextColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list : Icons.grid_view,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder<List<Lesson>>(
        future: _lessonController.fetchLessons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No lessons available'));
          } else {
            return _isGridView
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _buildLessonItem(snapshot.data![index]);
                    },
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _buildLessonItem(snapshot.data![index]);
                    },
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(builder: (context) => AddLessonScreen()),
          )
              .then((value) {
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildLessonItem(Lesson lesson) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                lesson.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                lesson.description,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.play_arrow,
                  size: 14,
                ),
                label: const Text('Watch Video'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          VideoPlayerScreen(videoUrl: lesson.videoUrl),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => AddLessonScreen(lesson: lesson),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 20,
                  ),
                  onPressed: () async {
                    await _lessonController.deleteLesson(lesson.id);
                    setState(
                      () {},
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
