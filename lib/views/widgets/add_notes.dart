// import 'package:flutter/material.dart';
// import 'package:main/models/notes.dart';
// import 'package:main/utils/app_contants.dart';

// class NotesItem extends StatefulWidget {
//   final Notes? notes;

//   const NotesItem({Key? key, this.notes}) : super(key: key);

//   @override
//   _NotesItemState createState() => _NotesItemState();
// }

// class _NotesItemState extends State<NotesItem> {
//   late TextEditingController _nameController;
//   late TextEditingController _phoneController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(
//       text: widget.notes?.name ?? '',
//     );
//     _phoneController = TextEditingController(
//       text: widget.notes?.phone ?? '',
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   void _saveNote() {
//     if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
//       return;
//     }
//     final newNote = Notes(
//       id: widget.notes?.id,
//       name: _nameController.text,
//       phone: _phoneController.text,
//     );
//     Navigator.of(context).pop(newNote);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//         widget.notes == null ? 'Add Note' : 'Edit Note',
//         style: TextStyle(
//           fontSize: AppConstants.appBarTextSize,
//         ),
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Name',
//                 labelStyle: TextStyle(fontSize: 18),
//               ),
//             ),
//             TextField(
//               controller: _phoneController,
//               decoration: const InputDecoration(
//                 labelText: 'Content',
//                 labelStyle: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: _saveNote,
//           child: const Text(
//             'Save',
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text(
//             'Cancel',
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:main/models/notes.dart';

class NotesItem extends StatefulWidget {
  final Notes? notes;

  const NotesItem({Key? key, this.notes}) : super(key: key);

  @override
  _NotesItemState createState() => _NotesItemState();
}

class _NotesItemState extends State<NotesItem> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.notes?.name ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.notes?.phone ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      return;
    }
    final newNote = Notes(
      id: widget.notes?.id,
      name: _nameController.text,
      phone: _phoneController.text,
    );
    Navigator.of(context).pop(newNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.notes == null ? 'Add Note' : 'Edit Note',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                labelStyle: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
