import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';

class DbHelper {
  Database? _database;
  final String _dbName = 'bukusaku.db';
  final String _dbSyntax =
      '''CREATE TABLE catatan( id INTEGER PRIMARY KEY AUTOINCREMENT, judul TEXT, uraian TEXT, kodeButir TEXT,
  jumlahKegiatan INTEGER, angkaKredit INTEGER, status INTEGER, idProfil INTEGER)''';
  final String _dbSyntax2 =
      '''CREATE TABLE bukti_fisik( id INTEGER PRIMARY KEY AUTOINCREMENT, idCatatan INTEGER, path TEXT,
  namaFile TEXT, extension TEXT)''';
  final String _dbSyntax3 =
      '''CREATE TABLE tanggal_kegiatan( id INTEGER PRIMARY KEY AUTOINCREMENT, idCatatan INTEGER, tanggal TEXT)''';
  final String _dbSyntax4 =
      '''CREATE TABLE profil( id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, fotoProfil TEXT, idJenjang INTEGER,
  akSaatIni DOUBLE(200,3), akUtamaTerkumpul DOUBLE(200,3), akPenunjangTerkumpul DOUBLE(200,3))''';
  final String _dbSyntax5 =
      '''CREATE TABLE jenjang( id INTEGER PRIMARY KEY, kodeJenjang INTEGER, jenjang TEXT, golongan TEXT )''';
  final String _dbSyntax6 =
      '''INSERT INTO jenjang VALUES (0, 11, "Pranata Komputer Terampil", "IIc"), (1, 11, "Pranata Komputer Terampil", "IId"),
      (2, 12, "Pranata Komputer Mahir", "IIIa"), (3, 12, "Pranata Komputer Mahir", "IIIb"), (4, 13, "Pranata Komputer Penyelia", "IIIc"),
      (5, 13, "Pranata Komputer Penyelia", "IIId"), (6, 21, "Pranata Komputer Ahli Pertama", "IIIa"),
      (7, 21, "Pranata Komputer Ahli Pertama", "IIIb"), (8, 22, "Pranata Komputer Ahli Muda", "IIIc"),
      (9, 22, "Pranata Komputer Ahli Muda", "IIId"), (10, 23, "Pranata Komputer Ahli Madya", "IVa"),
      (11, 23, "Pranata Komputer Ahli Madya", "IVb"), (12, 23, "Pranata Komputer Ahli Madya", "IVc"),
      (13, 24, "Pranata Komputer Ahli Utama", "IVd"), (14, 24, "Pranata Komputer Ahli Utama", "IVe")''';

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
        db.execute(_dbSyntax6);
      },
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await dbInstance;
    final List<Map<String, dynamic>> maps = await db.query('catatan');
    final List<Map<String, dynamic>> maps2 = await db.query('tanggal_kegiatan');

    return List.generate(maps.length, (i) {
      // perlukah tanggal disini ? keknya ga kepake, cma kepake di notebyid
      List<DateTime>? listTanggal = [];
      if (maps2.isNotEmpty) {
        for (var item in maps2) {
          if (item['idCatatan'] == maps[i]['id']) {
            listTanggal.add(DateTime.parse(item['tanggal']));
          }
        }
      }
      return Note(
        id: maps[i]['id'],
        judul: maps[i]['judul'],
        uraian: maps[i]['uraian'],
        status: maps[i]['status'],
        listTanggal: listTanggal,
      );
    });
  }

  Future<Note> getNoteById(int id) async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps =
        await db.query('catatan', where: 'id = ?', whereArgs: [id]);
    final List<Map<String, dynamic>> files =
        await db.query('bukti_fisik', where: 'idCatatan = ?', whereArgs: [id]);
    final List<Map<String, dynamic>> dates = await db
        .query('tanggal_kegiatan', where: 'idCatatan = ?', whereArgs: [id]);

    List<BuktiFisik> buktiFisik = List.generate(
      files.length,
      (index) => BuktiFisik(
        id: files[index]['id'],
        idCatatan: files[index]['idCatatan'],
        path: files[index]['path'],
        namaFile: files[index]['namaFile'],
        extension: files[index]['extension'],
      ),
    );

    List<DateTime>? listTanggal = [];
    if (dates.isNotEmpty) {
      for (var item in dates) {
        listTanggal.add(DateTime.parse(item['tanggal']));
      }
    }
    return Note(
      id: maps[0]['id'],
      judul: maps[0]['judul'],
      uraian: maps[0]['uraian'],
      // kodeButir: maps[0]['kodeButir'],
      // tanggalKegiatan: DateTime.parse(maps[0]['tanggalKegiatan']),
      jumlahKegiatan: maps[0]['jumlahKegiatan'],
      angkaKredit: maps[0]['angkaKredit'],
      status: maps[0]['status'],

      // this.dateCreated,
      listTanggal: listTanggal,
      buktiFisik: buktiFisik,
    );
  }

  Future<List<Note>> getNoteByKey(String key) async {
    final db = await dbInstance;

    // TODO : nanti jangan cuma judul, tapi uraian juga bisa masuk pencarian
    final List<Map<String, dynamic>> maps =
        await db.query('catatan', where: 'judul LIKE ?', whereArgs: ['%$key%']);

    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        judul: maps[i]['judul'],
        uraian: maps[i]['uraian'],
        status: maps[i]['status'],
        // tanggalKegiatan: DateTime.parse(maps[i]['tanggalKegiatan']),
        // tanggal dan bukti fisik ga perlu kan ya, karna ga dicantumin di hasil pencarian
      );
    });
  }

  Future<void> saveNote(Note note) async {
    final db = await dbInstance;

    final insertedId = await db.insert('catatan', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (note.buktiFisik != null) {
      for (var bukti in note.buktiFisik!) {
        await db.insert('bukti_fisik', bukti.toMap(insertedId),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
    if (note.listTanggal != null) {
      for (var tanggal in note.listTanggal!) {
        await db.insert('tanggal_kegiatan',
            {"idCatatan": insertedId, "tanggal": tanggal.toString()},
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  Future<int> updateNote(Note note) async {
    final db = await dbInstance;

    final updateCount = await db
        .update('catatan', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    await db
        .delete('bukti_fisik', where: 'idCatatan = ?', whereArgs: [note.id]);
    if (note.buktiFisik != null) {
      for (var bukti in note.buktiFisik!) {
        await db.insert('bukti_fisik', bukti.toMap(note.id!),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
    await db.delete('tanggal_kegiatan',
        where: 'idCatatan = ?', whereArgs: [note.id]);
    if (note.listTanggal != null) {
      for (var tanggal in note.listTanggal!) {
        await db.insert('tanggal_kegiatan',
            {"idCatatan": note.id, "tanggal": tanggal.toString()},
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    return updateCount;
  }

  Future<void> deleteNote(int noteId) async {
    final db = await dbInstance;

    await db.delete('catatan', where: 'id = ?', whereArgs: [noteId]);
    await db.delete('bukti_fisik', where: 'idCatatan = ?', whereArgs: [noteId]);
    await db.delete('tanggal_kegiatan',
        where: 'idCatatan = ?', whereArgs: [noteId]);
  }
}
