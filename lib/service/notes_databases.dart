// ignore_for_file: depend_on_referenced_packages

import 'package:main/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  LocalDatabase._singleton();

  static final LocalDatabase _localDatabase = LocalDatabase._singleton();

  factory LocalDatabase() {
    return _localDatabase;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDataBase,
    );
  }

  Future<void> _createDataBase(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      content TEXT NOT NULL
    )''');
  }

  Future<void> addNotes(Notes note) async {
    final db = await database;
    await db.insert("contacts", note.toMap());
  }

  Future<Notes?> getNotes(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "contacts",
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Notes.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Notes>> getAllNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("contacts");
    return List.generate(maps.length, (i) {
      return Notes.fromMap(maps[i]);
    });
  }

  Future<void> updateNotes(Notes note) async {
    final db = await database;
    await db.update(
      "contacts",
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNotes(int id) async {
    final db = await database;
    await db.delete(
      "contacts",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}