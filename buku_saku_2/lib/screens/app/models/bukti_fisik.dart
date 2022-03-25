class BuktiFisik {
  final int? id;
  final String path;
  final int? idNote;
  final String? fileName;
  final String? extension;

  BuktiFisik({
    this.id,
    required this.path,
    this.idNote,
    this.fileName,
    this.extension,
  });

  Map<String, dynamic> toMap(int idNote) {
    return {
      'id': id,
      'path': path,
      'idNote': idNote,
      'fileName': fileName,
      'extension': extension,
    };
  }
}
