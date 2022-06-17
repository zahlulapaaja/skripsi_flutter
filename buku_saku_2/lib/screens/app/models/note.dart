class Note {
  int? id;
  String? judul;
  String uraian;
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
  List<DateTime>? listTanggal;
  List<DocFile>? buktiFisik;

  // int status :
  // 0 = nothing
  // 1 = urgent
  // 2 = pinned
  // 3 = checked

// ini judul sama kode butir harusnya required jga
  Note({
    this.id,
    this.judul,
    required this.uraian,
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
    this.listTanggal,
    this.buktiFisik,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'uraian': uraian,
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

  List<dynamic> toList() {
    return [
      // pikir format yang paling baik utk semua itu, terutama tanggal tu
      id,
      judul,
      uraian,
      kodeButir,
      jumlahKegiatan,
      angkaKredit,
      isTim ? "ya" : "tidak",
      isTim ? jmlAnggota : 0,
      isTim ? peranDalamTim : "",
      listTanggal,
      status,
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
