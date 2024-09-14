import 'package:flutter/material.dart';
import 'package:main/models/course.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  final List<Course> data;
  final Function(List<Course>) updateSearchResults;

  SearchViewDelegate(this.data, this.updateSearchResults);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          updateSearchResults(data);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = query.isEmpty
        ? data
        : data.where((course) {
            final titleLower = course.title.toLowerCase();
            final queryLower = query.toLowerCase();
            return titleLower.contains(queryLower);
          }).toList();

    updateSearchResults(results);
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final course = results[index];
        return ListTile(
          title: Text(course.title),
          subtitle: Text('Price: \$${course.price}'),
          onTap: () {
            close(context, course.title);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? data
        : data.where((course) {
            final titleLower = course.title.toLowerCase();
            final queryLower = query.toLowerCase();
            return titleLower.contains(queryLower);
          }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final course = suggestions[index];
        return ListTile(
          title: Text(course.title),
          subtitle: Text('Price: \$${course.price}'),
          onTap: () {
            query = course.title;
            showResults(context);
          },
        );
      },
    );
  }
}
