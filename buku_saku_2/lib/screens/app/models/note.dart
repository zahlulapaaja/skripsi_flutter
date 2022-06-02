import 'package:buku_saku_2/screens/app/models/bukti_fisik.dart';
import 'package:buku_saku_2/screens/app/models/database.dart';

class Note {
  // TODO : Nanti hapus semua null checknya
  // Ga juga sih, soalnya kan di halaman awal ga perlu semua atribut, cukup judul, uraian, gambar klo ada, dan status
  // Ga perlu juga sih semua data itu, yg penting koe butirnya, nanti kan bisa panggil ke data json detailnya
  int? id;
  String? judul;
  String? uraian;
  String? kodeButir;
  DateTime? tanggalKegiatan;
  int jumlahKegiatan;
  double angkaKredit;
  int? status;
  int? personId;
  DateTime? dateCreated;
  List<BuktiFisik>? buktiFisik;

  // int status :
  // 0 = nothing
  // 1 = urgent
  // 2 = pinned
  // 3 = checked

  // nanti ini di tabel profile
  final String? jenjang;

  Note({
    this.id,
    this.judul,
    this.uraian,
    this.kodeButir,
    this.tanggalKegiatan,
    this.jumlahKegiatan = 1,
    this.angkaKredit = 0,
    this.status,
    this.personId,
    this.dateCreated,
    this.buktiFisik,
    this.jenjang,
  });

  //cari yg pake to map ini, biar diganti, ga error
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'uraian': uraian,
      'tanggalKegiatan': tanggalKegiatan.toString(),
      'jumlahKegiatan': jumlahKegiatan,
      'angkaKredit': angkaKredit,
      'status': status,
      'personId': personId,
    };
  }
}
