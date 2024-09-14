import 'package:flutter/material.dart';
import 'package:main/models/course.dart';


class CartProvider extends ChangeNotifier {
  List<Course> _favorites = [];
  List<Course> _cart = [];

  List<Course> get favorites => _favorites;
  List<Course> get cart => _cart;

  void addToFavorites(Course course) {
    if (!_favorites.contains(course)) {
      _favorites.add(course);
      notifyListeners();
    }
  }

  void removeFromFavorites(Course course) {
    _favorites.remove(course);
    notifyListeners();
  }

  void addToCart(Course course) {
    if (!_cart.contains(course)) {
      _cart.add(course);
      notifyListeners();
    }
  }

  void removeFromCart(Course course) {
    _cart.remove(course);
    notifyListeners();
  }
}
