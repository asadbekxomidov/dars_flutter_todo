import 'package:main/models/course.dart';

class ShoppingCart {
  List<Course> courses = [];

  void addToCart(Course course) {
    courses.add(course);
  }

  void removeFromCart(Course course) {
    courses.remove(course);
  }

  bool isInCart(Course course) {
    return courses.contains(course);
  }
}

class FavoriteCourses {
  List<Course> courses = [];

  void addToFavorites(Course course) {
    courses.add(course);
  }

  void removeFromFavorites(Course course) {
    courses.remove(course);
  }

  bool isFavorite(Course course) {
    return courses.contains(course);
  }
}
