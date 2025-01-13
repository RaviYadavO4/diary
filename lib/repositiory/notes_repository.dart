import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class NotesRepository {
  static const _databaseName = 'notes_database.dp';
  static const _tableName = 'notes';
  static const _dbVersion = 1;
  static const _query = 'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdAt TEXT)';

  static Future<Database> _database() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(_query);
        },
      version: _dbVersion,
    );
    return database;
  }

  static insert({required Note note}) async {

    final db = await _database();
    await db.insert(_tableName, note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

  }



  static update({required Note note}) async {
    final db = await _database();
    await db.update(_tableName, note.toMap(), where: 'id = ?', whereArgs: [note.id],);
  }

  static delete({required Note note}) async {
    final db = await _database();
    await db.delete(_tableName, where: 'id = ?', whereArgs: [note.id],);
  }

  static Future<List<Note>> getNotes() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    debugPrint(maps.toString());
    List<Note> notes = maps.map((e)=> Note.fromMap(e)).toList();
    return notes;
  }
}
