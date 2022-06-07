class Note {
  // TODO : Nanti hapus semua null checknya
  // Ga juga sih, soalnya kan di halaman awal ga perlu semua atribut, cukup judul, uraian, gambar klo ada, dan status
  // Ga perlu juga sih semua data itu, yg penting koe butirnya, nanti kan bisa panggil ke data json detailnya
  int? id;
  String? judul;
  String? uraian;
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
  final String? jenjang;

  Note({
    this.id,
    this.judul,
    this.uraian,
    this.kodeButir,
    this.listTanggal,
    this.jumlahKegiatan = 1,
    this.angkaKredit = 0,
    this.akSatuan,
    this.status,
    this.idProfil,
    this.dateCreated,
    this.buktiFisik,
    this.jenjang,
  });

  //cari yg pake to map ini, biar diganti, ga error
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'kodeButir': kodeButir,
      'uraian': uraian,
      'jumlahKegiatan': jumlahKegiatan,
      'angkaKredit': angkaKredit,
      'status': status,
      'idProfil': idProfil,
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
