import 'package:app_de_notas/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Operation {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, content TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<Future<int>> insert(Note note) async {
    Database database = await _openDB();
    return database.insert("notes", note.toMap());
  }

  static Future<Future<int>> update(Note note) async {
    Database database = await _openDB();
    return database.update("notes", note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }
  static Future<Future<int>> delete(Note note) async {
    Database database = await _openDB();
    return database.delete("notes", where: 'id = ?', whereArgs: [note.id]);
  }
  static Future<List<Note>> notes() async {
    Database database = await _openDB();
    final List<Map<String, Object?>> notesMap = await database.query("notes");

    // for (var n in notesMap) {
    //   print("____" + n['title'] as String);
    // }

    return notesMap.map((n) {
    return Note(
      id: n['id'] as int,
      title: n['title'] as String? ?? '',
      content: n['content'] as String? ?? '',
    );
  }).toList();
  }
}
