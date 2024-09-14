import 'package:flutter/material.dart';
import 'package:main/controllers/note_controller.dart';
import 'package:main/models/notes.dart';
import 'package:main/views/widgets/add_notes.dart';
import 'package:main/views/widgets/custom_drawer.dart';
import 'package:main/views/widgets/note_search_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NotesScreens extends StatefulWidget {
  const NotesScreens({super.key});

  @override
  _NotesScreensState createState() => _NotesScreensState();
}

class _NotesScreensState extends State<NotesScreens> {
  final NotesController _notesController = NotesController();
  List<Notes> filteredNotes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    await _notesController.fetchNotes();
    setState(() {
      filteredNotes = _notesController.note;
    });
  }

  void _addNotes(Notes contact) async {
    await _notesController.addNotes(contact);
    _loadNotes();
  }

  void _updateNotes(Notes contact) async {
    await _notesController.updateNotes(contact);
    _loadNotes();
  }

  void _deleteNotes(int id) async {
    await _notesController.deleteNotes(id);
    _loadNotes();
  }

  void _updateSearchResults(List<Notes> results) {
    setState(() {
      filteredNotes = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.note,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NoteSearchDelegate(_notesController.note, _updateSearchResults),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: filteredNotes.length,
        itemBuilder: (context, index) {
          final contact = filteredNotes[index];
          return Padding(
            padding: const EdgeInsets.all(10.5),
            child: Card(
              shadowColor: Colors.black,
              color: Theme.of(context).cardColor,
              child: ListTile(
                title: Text(
                  contact.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  contact.phone,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 25,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _deleteNotes(contact.id!);
                  },
                ),
                onTap: () async {
                  final updatedNotes = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotesItem(notes: contact),
                    ),
                  );
                  if (updatedNotes != null) {
                    _updateNotes(updatedNotes);
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNotes = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NotesItem(),
            ),
          );
          if (newNotes != null) {
            _addNotes(newNotes);
          }
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
