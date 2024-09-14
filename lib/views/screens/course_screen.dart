// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:main/controllers/course_controller.dart';
import 'package:main/models/course.dart';
import 'package:main/utils/app_contants.dart';
import 'package:main/utils/card_provider.dart';
import 'package:main/views/screens/card_sceen.dart';
import 'package:main/views/screens/favorite_screens.dart';
import 'package:main/views/widgets/add_course.dart';
import 'package:main/views/widgets/custom_drawer.dart';
import 'package:main/views/widgets/search_course_delegate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  _CourseListScreenState createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final CourseController _courseController = CourseController();
  bool _isGridView = true;
  List<Course> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _initializeCourses();
  }

  void _initializeCourses() async {
    final courses = await _courseController.fetchCourses();
    setState(() {
      _filteredCourses = courses;
    });
  }

  void _updateSearchResults(List<Course> results) {
    setState(() {
      _filteredCourses = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appBarColor,
        title: Text(
          AppLocalizations.of(context)!.course,
          style: TextStyle(
            fontSize: AppConstants.appBarTextSize,
            color: AppConstants.appBarTextColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => FavoriteScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 22,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => CartScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.teal,
              size: 22,
            ),
          ),
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list : Icons.grid_view,
            ),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchViewDelegate(
                  _filteredCourses,
                  _updateSearchResults,
                ),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _buildCourseList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(builder: (context) => const AddCourseScreen()),
          )
              .then((value) {
            setState(() {
              _initializeCourses();
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCourseList() {
    if (_filteredCourses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return _isGridView
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
            ),
            itemCount: _filteredCourses.length,
            itemBuilder: (context, index) {
              return _buildCourseItem(_filteredCourses[index]);
            },
          )
        : ListView.builder(
            itemCount: _filteredCourses.length,
            itemBuilder: (context, index) {
              return _buildCourseItem(_filteredCourses[index]);
            },
          );
  }

  Widget _buildCourseItem(Course course) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                course.imageUrl,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite_outline_sharp,
                          color: Colors.red,
                          size: 18,
                        ),
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .addToFavorites(course);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        course.description,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price: \$${course.price}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.teal,
                          size: 15,
                        ),
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .addToCart(course);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
