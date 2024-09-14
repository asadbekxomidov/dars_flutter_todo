// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:main/models/course.dart';
import 'package:main/utils/app_contants.dart';
import 'package:main/utils/card_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appBarColor,
        centerTitle: true,
        title: Text(
          'Favorites',
          style: TextStyle(
            fontSize: AppConstants.appBarTextSize,
            color: AppConstants.appBarTextColor,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.favorites.isEmpty) {
            return const Center(
              child: Text(
                'No favorites added',
              ),
            );
          } else {
            return ListView.builder(
              itemCount: cart.favorites.length,
              itemBuilder: (context, index) {
                Course course = cart.favorites[index];
                return ListTile(
                  leading: Image.network(course.imageUrl),
                  title: Text(course.title),
                  subtitle: Text('${course.price} so\'m'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      size: 25,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .removeFromFavorites(course);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
