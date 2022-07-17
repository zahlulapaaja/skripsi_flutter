import 'dart:io';

import 'package:buku_saku_2/screens/app/models/doc_file.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Stack;

class Note {
  int? id;
  String? judul;
  String uraian;
  String? satuanHasil;
  String? kodeButir;
  int jumlahKegiatan;
  double angkaKredit;
  double? akSatuan;
  bool isTim;
  int jmlAnggota;
  String? peranDalamTim;
  int? status;
  int? idProfil;
  DateTime? dateCreated;
  List<TanggalKegiatan> listTanggal;
  List<DocFile>? buktiFisik;
  DocFile? spmk;

  // int status :
  // 0 = nothing
  // 1 = urgent
  // 2 = pinned
  // 3 = checked

  Note({
    this.id,
    this.judul,
    required this.uraian,
    this.satuanHasil,
    this.kodeButir,
    this.jumlahKegiatan = 1,
    this.angkaKredit = 0,
    this.isTim = false,
    this.jmlAnggota = 2,
    this.peranDalamTim,
    this.status,
    this.idProfil,
    this.dateCreated,
    this.akSatuan,
    required this.listTanggal,
    this.buktiFisik,
    this.spmk,
  });

  String get getDateCreated =>
      DateFormat("d MMMM yyyy", "id_ID").format(dateCreated!);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'uraian': uraian,
      'satuanHasil': satuanHasil,
      'kodeButir': kodeButir,
      'jumlahKegiatan': jumlahKegiatan,
      'angkaKredit': angkaKredit,
      'isTim': isTim ? 1 : 0,
      'jumlahAnggota': jmlAnggota,
      'peranDalamTim': peranDalamTim,
      'spmkFilePath': spmk?.getPath,
      'spmkFileName': spmk?.getName,
      'spmkFileExtension': spmk?.getExtension,
      'spmkFileSize': spmk?.getSize,
      'status': status,
      'idProfil': idProfil,
      'dateCreated': dateCreated.toString(),
    };
  }

  static List<String> listTitle = [
    "No",
    "Uraian",
    "Kode Butir",
    "Tanggal",
    "Satuan Hasil",
    "Jumlah Volume Kegiatan",
    "Jumlah Angka Kredit",
    "Kegiatan Tim",
    "Jumlah Anggota",
    "Peran Dalam Tim",
    // "status",
    "date_created",
  ];

  List<dynamic> toList(int number) {
    String tanggal = "";
    for (var element in listTanggal) {
      if (element != listTanggal.first) tanggal += ", ";
      tanggal += element.tanggalToString();
    }
    return [
      number.toString(),
      uraian,
      kodeButir,
      tanggal,
      satuanHasil,
      jumlahKegiatan,
      angkaKredit,
      isTim ? "Ya" : "Tidak",
      isTim ? jmlAnggota : 0,
      isTim ? peranDalamTim : "",
      // status,
      dateCreated,
    ];
  }

  static Future<DocFile> createExcel(List<Note> notes) async {
    // membuat file excel
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    // input title ke row pertama
    sheet.importList(Note.listTitle, 1, 1, false);

    // input data dari database
    for (int i = 0; i < notes.length; i++) {
      // +2 karna ga ada baris 0, dan baris satu udh diisi title
      sheet.importList(notes[i].toList(i), i + 2, 1, false);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // memanggil path dan menyimpan file
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = 'Ekspor_Catatan_' +
        DateFormat("yyyyMMdd_HHmmss", "id_ID").format(DateTime.now()) +
        '.xlsx';
    final File file = File('$path/$fileName');
    final newFile = await file.writeAsBytes(bytes, flush: true);

    return DocFile(
      path: newFile.path,
      name: fileName.split('.')[0],
      extension: ".xlsx",
      dateCreated: DateTime.now(),
    );
  }
}

class TanggalKegiatan {
  final int? id;
  DateTime? tanggalMulai;
  DateTime? tanggalBerakhir;
  final int? idCatatan;

  TanggalKegiatan({
    this.id,
    this.tanggalMulai,
    this.tanggalBerakhir,
    this.idCatatan,
  });

  String tanggalToString() {
    return (tanggalBerakhir == null)
        ? (DateFormat("dd/MM/yyyy", "id_ID").format(tanggalMulai!)).toString()
        : (DateFormat("dd/MM/yyyy", "id_ID").format(tanggalMulai!)).toString() +
            " - " +
            (DateFormat("dd/MM/yyyy", "id_ID").format(tanggalBerakhir!))
                .toString();
  }

  Map<String, dynamic> toMap({int? idCatatan}) {
    return {
      'id': id,
      'tanggalMulai': tanggalMulai.toString(),
      'tanggalBerakhir':
          (tanggalBerakhir != null) ? tanggalBerakhir.toString() : null,
      'idCatatan': idCatatan,
    };
  }
}
