import 'package:flutter/material.dart';
import 'package:main/models/notes.dart';

class NoteSearchDelegate extends SearchDelegate<String> {
  final List<Notes> notes;
  final Function(List<Notes>) updateSearchResults;

  NoteSearchDelegate(this.notes, this.updateSearchResults);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          updateSearchResults(notes);
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
        ? notes
        : notes.where((note) {
            final nameLower = note.name.toLowerCase();
            final phoneLower = note.phone.toLowerCase();
            final queryLower = query.toLowerCase();
            return nameLower.contains(queryLower) ||
                phoneLower.contains(queryLower);
          }).toList();

    updateSearchResults(results);
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final note = results[index];
        return ListTile(
          title: Text(note.name),
          subtitle: Text(note.phone),
          onTap: () {
            query = note.name;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? notes
        : notes.where((note) {
            final nameLower = note.name.toLowerCase();
            final phoneLower = note.phone.toLowerCase();
            final queryLower = query.toLowerCase();
            return nameLower.contains(queryLower) ||
                phoneLower.contains(queryLower);
          }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final note = suggestions[index];
        return ListTile(
          title: Text(note.name),
          subtitle: Text(note.phone),
          onTap: () {
            query = note.name;
            showResults(context);
          },
        );
      },
    );
  }
}
