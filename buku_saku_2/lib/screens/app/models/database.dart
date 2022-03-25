import 'dart:async';
import 'package:buku_saku_2/screens/app/models/bukti_fisik.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';

class DbHelper {
  Database? _database;
  final String _dbName = 'bukusaku.db';
  final String _dbSyntax =
      '''CREATE TABLE notes( id INTEGER PRIMARY KEY AUTOINCREMENT, judul TEXT, uraian TEXT, kodeButir TEXT,
  tanggalKegiatan TEXT, jumlahKegiatan INTEGER, angkaKredit INTEGER, status INTEGER, personId INTEGER)''';
  final String _dbSyntax2 =
      '''CREATE TABLE bukti_fisik( id INTEGER PRIMARY KEY AUTOINCREMENT, idNote INTEGER, path TEXT,
  fileName TEXT, extension TEXT)''';

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
        db.execute(_dbSyntax);
        db.execute(_dbSyntax2);
      },
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db.query('notes');
    final List<Map<String, dynamic>> files = await db.query('bukti_fisik');
    return List.generate(maps.length, (i) {
      List<BuktiFisik> buktiFisik = [];
      for (var file in files) {
        if (file['idNote'] == maps[i]['id']) {
          buktiFisik
              .add(BuktiFisik(path: file['path'], fileName: file['fileName']));
        }
      }
      return Note(
        id: maps[i]['id'],
        judul: maps[i]['judul'],
        uraian: maps[i]['uraian'],
        status: maps[i]['status'],
        tanggalKegiatan: DateTime.parse(maps[i]['tanggalKegiatan']),
        buktiFisik: buktiFisik,
      );
    });
  }

  Future<Note> getNoteById(int id) async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps =
        await db.query('notes', where: 'id = ?', whereArgs: [id]);
    final List<Map<String, dynamic>> files =
        await db.query('bukti_fisik', where: 'idNote = ?', whereArgs: [id]);

    List<BuktiFisik> buktiFisik = List.generate(
        files.length,
        (index) => BuktiFisik(
              id: files[index]['id'],
              idNote: files[index]['idNote'],
              path: files[index]['path'],
              fileName: files[index]['fileName'],
              extension: files[index]['extension'],
            ));
    return Note(
      id: maps[0]['id'],
      judul: maps[0]['judul'],
      uraian: maps[0]['uraian'],
      // kodeButir: maps[0]['kodeButir'],
      tanggalKegiatan: DateTime.parse(maps[0]['tanggalKegiatan']),
      jumlahKegiatan: maps[0]['jumlahKegiatan'],
      angkaKredit: maps[0]['angkaKredit'],
      status: maps[0]['status'],

      // this.personId,
      // this.dateCreated,
      // this.jenjang,
      buktiFisik: buktiFisik,
    );
  }

  Future<void> saveNote(Note note) async {
    final db = await dbInstance;

    final insertedId = await db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (note.buktiFisik != null) {
      for (var bukti in note.buktiFisik!) {
        await db.insert('bukti_fisik', bukti.toMap(insertedId),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  Future<void> updateNote(Note note) async {
    final db = await dbInstance;

    final insertedId = await db
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    if (note.buktiFisik != null) {
      await db.delete('bukti_fisik', where: 'idNote = ?', whereArgs: [note.id]);
      for (var bukti in note.buktiFisik!) {
        await db.insert('bukti_fisik', bukti.toMap(insertedId),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  Future<void> deleteNote(noteId) async {
    final db = await dbInstance;

    await db.delete('notes', where: 'id = ?', whereArgs: [noteId]);
  }
}
