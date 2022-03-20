import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';

class DbHelper {
  Database? _database;
  final String _dbName = 'bukusaku.db';
  final String _dbSyntax = '''CREATE TABLE notes(
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  judul TEXT, uraian TEXT,
  tanggalKegiatan TEXT, jumlahKegiatan INTEGER, 
  angkaKredit INTEGER, status INTEGER, 
  personId INTEGER)''';

  Future<Database> get dbInstance async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), _dbName),
      version: 1,
      onCreate: (db, version) {
        return db.execute(_dbSyntax);
      },
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        judul: maps[i]['judul'],
        uraian: maps[i]['uraian'],
        status: maps[i]['status'],
      );
    });
  }

  Future<void> saveNote(Note note) async {
    final db = await dbInstance;

    await db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteNote(noteId) async {
    final db = await dbInstance;

    await db.delete('notes', where: 'id = ?', whereArgs: [noteId]);
  }
}
