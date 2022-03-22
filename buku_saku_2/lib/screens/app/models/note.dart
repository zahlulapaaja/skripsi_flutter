class Note {
  // TODO : Nanti hapus semua null checknya
  // Ga juga sih, soalnya kan di halaman awal ga perlu semua atribut, cukup judul, uraian, gambar klo ada, dan status
  // Ga perlu juga sih semua data itu, yg penting koe butirnya, nanti kan bisa panggil ke data json detailnya
  final int? id;
  final String judul;
  final String uraian;
  final String? kodeButir;
  final String? tanggalKegiatan;
  final int? jumlahKegiatan;
  final double? angkaKredit;
  final int? status;
  final int? personId;
  final DateTime? dateCreated;

  // int status :
  // 0 = nothing
  // 1 = urgent
  // 2 = pinned
  // 3 = checked

  Note({
    this.id,
    required this.judul,
    required this.uraian,
    this.kodeButir,
    this.tanggalKegiatan,
    this.jumlahKegiatan,
    this.angkaKredit,
    this.status,
    this.personId,
    this.dateCreated,
  });

  //cari yg pake to map ini, biar diganti, ga error
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'uraian': uraian,
      'tanggalKegiatan': tanggalKegiatan,
      'jumlahKegiatan': jumlahKegiatan,
      'angkaKredit': angkaKredit,
      'status': status,
      'personId': personId,
    };
  }

  @override
  String toString() {
    return 'Note {personId: $personId, tanggalKegiatan: $tanggalKegiatan, jumlahKegiatan: $jumlahKegiatan}';
  }
}
