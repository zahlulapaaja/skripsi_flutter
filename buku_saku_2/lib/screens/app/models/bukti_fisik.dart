class BuktiFisik {
  final int? id;
  final String path;
  final int? idCatatan;
  final String? namaFile;
  final String? extension;

  BuktiFisik({
    this.id,
    required this.path,
    this.idCatatan,
    this.namaFile,
    this.extension,
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
