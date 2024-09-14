import 'package:flutter/material.dart';
import 'package:main/models/todo.dart';

class TodoSearchDelegate extends SearchDelegate<String> {
  final List<TodoApp> todos;
  final Function(List<TodoApp>) updateSearchResults;

  TodoSearchDelegate(this.todos, this.updateSearchResults);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          updateSearchResults(todos);
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
        ? todos
        : todos.where((todo) {
            final titleLower = todo.title.toLowerCase();
            final descriptionLower = todo.description.toLowerCase();
            final queryLower = query.toLowerCase();
            return titleLower.contains(queryLower) ||
                descriptionLower.contains(queryLower);
          }).toList();

    updateSearchResults(results);
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final todo = results[index];
        return ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.description),
          onTap: () {
            query = todo.title;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? todos
        : todos.where((todo) {
            final titleLower = todo.title.toLowerCase();
            final descriptionLower = todo.description.toLowerCase();
            final queryLower = query.toLowerCase();
            return titleLower.contains(queryLower) ||
                descriptionLower.contains(queryLower);
          }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final todo = suggestions[index];
        return ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.description),
          onTap: () {
            query = todo.title;
            showResults(context);
          },
        );
      },
    );
  }
}
