import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DocFile {
  int? _id;
  String? _path;
  int? _idCatatan;
  String? _name;
  String? _extension;
  DateTime? _dateCreated;
  int? _size;

  DocFile({
    int? id,
    String? path,
    int? idCatatan,
    String? name,
    String? extension,
    DateTime? dateCreated,
    int? size,
  }) {
    _id = id;
    _idCatatan = idCatatan;
    _path = path;
    _name = name;
    _extension = extension;
    _size = size;
    _dateCreated = dateCreated;
  }

  Map<String, dynamic> toMap({int? idCatatan}) {
    return {
      'id': _id,
      'path': _path,
      'name': _name,
      'extension': _extension,
      'size': _size,
      if (idCatatan != null) 'idCatatan': idCatatan,
      if (idCatatan == null) 'dateCreated': _dateCreated.toString(),
    };
  }

  int get getId => _id!;
  String get getName => _name!;
  String get getExtension => _extension!;
  String get getDateCreated =>
      DateFormat("dd MMM yyyy", "id_ID").format(_dateCreated!);

  void openFile() {
    OpenFile.open(_path);
  }

  void shareFile() {
    Share.shareFiles([_path!]);
  }

  void deleteFile() {
    File(_path!).delete();
  }

  static dynamic uploadFiles() async {
    return await FilePicker.platform.pickFiles(allowMultiple: true);
  }

  static Future<File> saveFiles(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }
}
