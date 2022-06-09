class Note {
  // TODO : Nanti hapus semua null checknya
  // Ga juga sih, soalnya kan di halaman awal ga perlu semua atribut, cukup judul, uraian, gambar klo ada, dan status
  // Ga perlu juga sih semua data itu, yg penting koe butirnya, nanti kan bisa panggil ke data json detailnya
  int? id;
  String? judul;
  String uraian;
  String? kodeButir;
  List<DateTime>? listTanggal;
  int jumlahKegiatan;
  double angkaKredit;
  int? status;
  int? idProfil;
  DateTime? dateCreated;
  List<BuktiFisik>? buktiFisik;

  // int status :
  // 0 = nothing
  // 1 = urgent
  // 2 = pinned
  // 3 = checked

// ini sementara, biar klo update, bisa panggil ak satuan
  double? akSatuan;
  // nanti ini di tabel profile
  bool isTim;
  int jmlAnggota;
  String? peranDalamTim;

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
      'isTim': isTim,
      'jmlAnggota': jmlAnggota,
      'peranDalamTim': peranDalamTim,
      'status': status,
      'idProfil': idProfil,
      'dateCreated': dateCreated,
    };
  }
}

class BuktiFisik {
  final int? id;
  final String path;
  final int? idCatatan;
  final String namaFile;
  final String extension;

  BuktiFisik({
    this.id,
    this.idCatatan,
    required this.path,
    required this.namaFile,
    required this.extension,
  });

  Map<String, dynamic> toMap(int idCatatan) {
    return {
      'id': id,
      'path': path,
      'idCatatan': idCatatan,
      'namaFile': namaFile,
      'extension': extension,
    };
  }
}
