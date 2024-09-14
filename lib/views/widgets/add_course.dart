// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:main/controllers/course_controller.dart';
import 'package:main/models/course.dart';

class AddCourseScreen extends StatefulWidget {
  final Course? course;

  const AddCourseScreen({this.course});

  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final CourseController _courseController = CourseController();
  late String _title;
  late String _description;
  late String _imageUrl;
  late double _price;

  @override
  void initState() {
    super.initState();
    if (widget.course != null) {
      _title = widget.course!.title;
      _description = widget.course!.description;
      _imageUrl = widget.course!.imageUrl;
      _price = widget.course!.price;
    } else {
      _title = '';
      _description = '';
      _imageUrl = '';
      _price = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? 'Add Course' : 'Edit Course'),
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
                initialValue: _imageUrl,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imageUrl = value!;
                },
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.course == null) {
                      await _courseController.addCourse(
                        Course(
                          id: DateTime.now().toString(),
                          title: _title,
                          description: _description,
                          imageUrl: _imageUrl,
                          lessons: [],
                          price: _price,
                        ),
                      );
                    } else {
                      await _courseController.updateCourse(
                        widget.course!.id,
                        Course(
                          id: widget.course!.id,
                          title: _title,
                          description: _description,
                          imageUrl: _imageUrl,
                          lessons: widget.course!.lessons,
                          price: _price,
                        ),
                      );
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                    widget.course == null ? 'Add Course' : 'Update Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
