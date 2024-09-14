// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:main/controllers/lesson_controller.dart';
import 'package:main/models/lesson.dart';


class AddLessonScreen extends StatefulWidget {
  final Lesson? lesson;

  AddLessonScreen({super.key, this.lesson});

  @override
  _AddLessonScreenState createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  final _formKey = GlobalKey<FormState>();
  final LessonController _lessonController = LessonController();
  late String _title;
  late String _description;
  late String _videoUrl;

  @override
  void initState() {
    super.initState();
    if (widget.lesson != null) {
      _title = widget.lesson!.title;
      _description = widget.lesson!.description;
      _videoUrl = widget.lesson!.videoUrl;
    } else {
      _title = '';
      _description = '';
      _videoUrl = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson == null ? 'Add Lesson' : 'Edit Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                initialValue: _videoUrl,
                decoration: const InputDecoration(labelText: 'Video URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the video URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _videoUrl = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.lesson == null) {
                      await _lessonController.addLesson(
                        Lesson(
                          id: DateTime.now().toString(),
                          courseId: '',
                          title: _title,
                          description: _description,
                          videoUrl: _videoUrl,
                        ),
                      );
                    } else {
                      await _lessonController.updateLesson(
                        widget.lesson!.id,
                        Lesson(
                          id: widget.lesson!.id,
                          courseId: widget.lesson!.courseId,
                          title: _title,
                          description: _description,
                          videoUrl: _videoUrl,
                        ),
                      );
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.lesson == null ? 'Add Lesson' : 'Update Lesson'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
