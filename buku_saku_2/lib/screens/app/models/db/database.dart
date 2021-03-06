import 'dart:async';
import 'package:buku_saku_2/screens/app/models/doc_file.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';

class DbHelper {
  Database? _database;
  final String _dbName = 'buku_saku_prakom.db';
  final String _dbSyntax =
      '''CREATE TABLE catatan( id INTEGER PRIMARY KEY AUTOINCREMENT, judul TEXT, uraian TEXT, satuanHasil TEXT, 
      kodeButir TEXT, jumlahKegiatan INTEGER, angkaKredit DOUBLE(200,3), isTim BIT, jumlahAnggota INTEGER, peranDalamTim TEXT, 
      spmkFilePath TEXT, spmkFileName TEXT, spmkFileExtension TEXT, spmkFileSize INTEGER, dateCreated TEXT, status INTEGER, idProfil INTEGER)''';
  final String _dbSyntax2 =
      '''CREATE TABLE bukti_fisik( id INTEGER PRIMARY KEY AUTOINCREMENT, idCatatan INTEGER, path TEXT,
      name TEXT, extension TEXT, size INTEGER)''';
  final String _dbSyntax3 =
      '''CREATE TABLE tanggal_kegiatan( id INTEGER PRIMARY KEY AUTOINCREMENT, idCatatan INTEGER, tanggalMulai TEXT,
      tanggalBerakhir TEXT)''';
  final String _dbSyntax4 =
      '''CREATE TABLE profil( id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, fotoProfil TEXT, ukuranFoto INTEGER,
      idJenjang INTEGER, akSaatIni DOUBLE(200,3))''';
  final String _dbSyntax5 =
      '''CREATE TABLE jenjang( id INTEGER PRIMARY KEY, kodeJenjang INTEGER, jenjang TEXT, golongan TEXT )''';
  final String _dbSyntax6 =
      '''CREATE TABLE excel_catatan( id INTEGER PRIMARY KEY AUTOINCREMENT, path TEXT, name TEXT, extension TEXT, 
      size INTEGER, dateCreated TEXT)''';
  final String _dbSyntax7 =
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
        db.execute(_dbSyntax7);
      },
    );
  }

  Future<List<Note>> getNotes({bool orderbyKodeButir = false}) async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = orderbyKodeButir
        ? await db.query('catatan', orderBy: "kodeButir ASC")
        : await db.query('catatan', orderBy: "dateCreated DESC");

    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        judul: maps[i]['judul'],
        uraian: maps[i]['uraian'],
        kodeButir: maps[i]['kodeButir'],
        angkaKredit: maps[i]['angkaKredit'],
        status: maps[i]['status'],
        dateCreated: DateTime.parse(maps[i]['dateCreated']),
        listTanggal: [],
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

    DocFile? spmk = (maps[0]['spmkFilePath'] != null)
        ? DocFile(
            path: maps[0]['spmkFilePath'],
            name: maps[0]['spmkFileName'],
            extension: maps[0]['spmkFileExtension'],
            size: maps[0]['spmkFileSize'],
          )
        : null;

    List<DocFile> buktiFisik = List.generate(
      files.length,
      (index) => DocFile(
        id: files[index]['id'],
        idCatatan: files[index]['idCatatan'],
        path: files[index]['path'],
        name: files[index]['name'],
        extension: files[index]['extension'],
        size: files[index]['size'],
      ),
    );

    List<TanggalKegiatan> listTanggal =
        List.generate(maps[0]['jumlahKegiatan'], (index) {
      if (index < dates.length) {
        return TanggalKegiatan(
          id: dates[index]['id'],
          idCatatan: dates[index]['idCatatan'],
          tanggalMulai: DateTime.parse(dates[index]['tanggalMulai']),
          tanggalBerakhir: (dates[index]['tanggalBerakhir'] != null)
              ? DateTime.parse(dates[index]['tanggalBerakhir'])
              : null,
        );
      } else {
        return TanggalKegiatan();
      }
    });

    return Note(
      id: maps[0]['id'],
      judul: maps[0]['judul'],
      uraian: maps[0]['uraian'],
      kodeButir: maps[0]['kodeButir'],
      satuanHasil: maps[0]['satuanHasil'],
      jumlahKegiatan: maps[0]['jumlahKegiatan'],
      angkaKredit: maps[0]['angkaKredit'],
      akSatuan: maps[0]['angkaKredit'] / maps[0]['jumlahKegiatan'],
      isTim: maps[0]['isTim'] == 0 ? false : true,
      jmlAnggota: maps[0]['jumlahAnggota'],
      peranDalamTim: maps[0]['peranDalamTim'],
      status: maps[0]['status'],
      dateCreated: DateTime.parse(maps[0]['dateCreated']),
      listTanggal: listTanggal,
      buktiFisik: buktiFisik,
      spmk: spmk,
      // this.idProfil,
    );
  }

  Future<List<Note>> getNoteByKey(String key) async {
    final db = await dbInstance;

    // Pencarian hanya berdasarkan judul
    final List<Map<String, dynamic>> maps = await db.query('catatan',
        where: 'judul LIKE ?', whereArgs: ['%$key%'], orderBy: "kodeButir ASC");

    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        judul: maps[i]['judul'],
        uraian: maps[i]['uraian'],
        status: maps[i]['status'],
        dateCreated: DateTime.parse(maps[i]['dateCreated']),
        listTanggal: [],
      );
    });
  }

  Future<void> saveNote(Note note) async {
    final db = await dbInstance;

    final insertedId = await db.insert('catatan', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    if (note.buktiFisik != null) {
      for (var bukti in note.buktiFisik!) {
        await db.insert('bukti_fisik', bukti.toMap(idCatatan: insertedId),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
    for (var tanggal in note.listTanggal) {
      if (tanggal.tanggalMulai != null) {
        await db.insert(
            'tanggal_kegiatan', tanggal.toMap(idCatatan: insertedId),
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
        await db.insert('bukti_fisik', bukti.toMap(idCatatan: note.id!),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    for (var tanggal in note.listTanggal) {
      if (tanggal.id != null) {
        if (tanggal.tanggalMulai == null) {
          await db.delete('tanggal_kegiatan',
              where: 'id = ?', whereArgs: [tanggal.id]);
        } else {
          await db.update(
              'tanggal_kegiatan', tanggal.toMap(idCatatan: note.id!),
              where: 'id = ?', whereArgs: [tanggal.id]);
        }
      } else {
        if (tanggal.tanggalMulai != null) {
          await db.insert(
              'tanggal_kegiatan', tanggal.toMap(idCatatan: note.id!),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
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

  Future<void> deleteAllNotes() async {
    final db = await dbInstance;

    await db.delete('catatan');
    await db.delete('bukti_fisik');
    await db.delete('tanggal_kegiatan');
  }

  Future<List<Note>> exportNotes() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps =
        await db.query('catatan', orderBy: "kodeButir ASC");
    final List<Map<String, dynamic>> dates = await db.query('tanggal_kegiatan');

    return List.generate(maps.length, (i) {
      List<TanggalKegiatan> listTanggal = [];

      for (var index = 0; index < dates.length; index++) {
        if (maps[i]['id'] == dates[index]['idCatatan']) {
          listTanggal.add(TanggalKegiatan(
            id: dates[index]['id'],
            idCatatan: dates[index]['idCatatan'],
            tanggalMulai: DateTime.parse(dates[index]['tanggalMulai']),
            tanggalBerakhir: (dates[index]['tanggalBerakhir'] != null)
                ? DateTime.parse(dates[index]['tanggalBerakhir'])
                : null,
          ));
        }
      }

      return Note(
        id: maps[i]['id'],
        judul: maps[i]['judul'],
        uraian: maps[i]['uraian'],
        kodeButir: maps[i]['kodeButir'],
        satuanHasil: maps[i]['satuanHasil'],
        jumlahKegiatan: maps[i]['jumlahKegiatan'],
        angkaKredit: maps[i]['angkaKredit'],
        isTim: maps[i]['isTim'] == 0 ? false : true,
        jmlAnggota: maps[i]['jumlahAnggota'],
        peranDalamTim: maps[i]['peranDalamTim'],
        status: maps[i]['status'],
        dateCreated: DateTime.parse(maps[i]['dateCreated']),
        listTanggal: listTanggal,
      );
    });
  }

  Future<List<DocFile>> getExportNote() async {
    final db = await dbInstance;
    final List<Map<String, dynamic>> maps =
        await db.query('excel_catatan', orderBy: "dateCreated");

    return List.generate(maps.length, (i) {
      return DocFile(
        id: maps[i]['id'],
        path: maps[i]['path'],
        name: maps[i]['name'],
        extension: maps[i]['extension'],
        dateCreated: DateTime.parse(maps[i]['dateCreated']),
      );
    });
  }

  Future<int> saveExportNote(DocFile file) async {
    final db = await dbInstance;
    final insertedId = await db.insert('excel_catatan', file.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return insertedId;
  }

  Future<void> deleteExportNote(int fileId) async {
    final db = await dbInstance;
    await db.delete('excel_catatan', where: 'id = ?', whereArgs: [fileId]);
  }
}
