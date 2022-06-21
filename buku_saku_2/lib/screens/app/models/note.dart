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
  });

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
      'jmlAnggota': jmlAnggota,
      'peranDalamTim': peranDalamTim,
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
    return [
      number.toString(),
      uraian,
      kodeButir,
      listTanggal,
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
}

class DocFile {
  final int? id;
  final String path;
  final int? idCatatan;
  final String name;
  final String extension;
  final DateTime? dateCreated;
  final int size;

  DocFile({
    this.id,
    this.idCatatan,
    required this.path,
    required this.name,
    required this.extension,
    this.dateCreated,
    this.size = 0,
  });

  Map<String, dynamic> toMap({int? idCatatan}) {
    return {
      'id': id,
      'path': path,
      'name': name,
      'extension': extension,
      'size': size,
      if (idCatatan != null) 'idCatatan': idCatatan,
      if (idCatatan == null) 'dateCreated': dateCreated.toString(),
    };
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
