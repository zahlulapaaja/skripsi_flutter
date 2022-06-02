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
  final String _dbSyntax3 =
      '''CREATE TABLE profile( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, profilePict TEXT, jenjang INTEGER,
  golongan TEXT, ak_now DOUBLE(200,3), ak_utama_collected DOUBLE(200,3), ak_penunjang_collected DOUBLE(200,3))''';

  final String _dbSyntax4 =
      '''CREATE TABLE jenjang( id INTEGER PRIMARY KEY, name TEXT )''';
  final String _dbSyntax5 =
      '''INSERT INTO jenjang VALUES (11, "Pranata Komputer Terampil"), (12, "Pranata Komputer Mahir"),
    (13, "Pranata Komputer Penyelia"), (21, "Pranata Komputer Ahli Pertama"), (22, "Pranata Komputer Ahli Muda"),
    (23, "Pranata Komputer Ahli Madya"), (24, "Pranata Komputer Ahli Utama")''';

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
        db.execute(_dbSyntax3);
        db.execute(_dbSyntax4);
        db.execute(_dbSyntax5);
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
        tanggalKegiatan: DateTime.parse(maps[i]['tanggalKegiatan']),
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

  Future<List<Note>> getNoteByKey(String key) async {
    final db = await dbInstance;

    // TODO : nanti jangan cuma judul, tapi uraian juga bisa masuk pencarian
    final List<Map<String, dynamic>> maps =
        await db.query('notes', where: 'judul LIKE ?', whereArgs: ['%$key%']);

    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        judul: maps[i]['judul'],
        uraian: maps[i]['uraian'],
        status: maps[i]['status'],
        tanggalKegiatan: DateTime.parse(maps[i]['tanggalKegiatan']),
      );
    });
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

  Future<void> deleteNote(int noteId) async {
    final db = await dbInstance;

    await db.delete('notes', where: 'id = ?', whereArgs: [noteId]);
  }

  // Future<String> getProfile() async {
  //   final db = await dbInstance;

  //   final List<Map<String, dynamic>> maps = await db.query('profile');
  //   print(maps);
  //   return maps[0]['name'];
  // }

  Future<void> saveProfileTest(String name) async {
    final db = await dbInstance;

    final insertedId = await db.insert(
        'profile',
        {
          'name': name,
          'profilePict': 'kosong',
          'jenjang': 'Prakom Aja',
          'ak_now': 14.9,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateNameTest(String data) async {
    // harusnya nanti yang dibawa disini adalah semua data, bukan cuma satu string
    final db = await dbInstance;

    final insertedId = await db.update(
        'profile',
        {
          'name': data,
          'profilePict': 'kosong',
          'jenjang': 'Prakom Aja',
          'ak_now': 14.9,
        },
        where: 'id = ?',
        whereArgs: [1]);
  }
}
