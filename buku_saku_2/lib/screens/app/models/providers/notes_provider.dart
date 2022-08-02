import 'package:buku_saku_2/screens/app/models/doc_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<DocFile> _excelFiles = [];
  String _searchKey = '';
  double _akUtamaTerkumpul = 0.0;
  double _akPenunjangTerkumpul = 0.0;
  bool _orderByKodeButir = false;
  var dbHelper = DbHelper();

  double get akUtamaTerkumpul => _akUtamaTerkumpul;
  double get akPenunjangTerkumpul => _akPenunjangTerkumpul;
  bool get isQueryExist => (_searchKey == '') ? false : true;
  String get query => _searchKey;

  Future<List<DocFile>> get excelFiles async {
    _excelFiles = await dbHelper.getExportNote();
    return _excelFiles;
  }

  Future<List<Note>> get notes async {
    if (_searchKey == '') {
      _orderByKodeButir
          ? _notes = await dbHelper.getNotes(orderbyKodeButir: true)
          : _notes = await dbHelper.getNotes();
      _akPenunjangTerkumpul = 0.0;
      _akUtamaTerkumpul = 0.0;
      for (Note note in _notes) {
        if (note.kodeButir!.startsWith('IV.') ||
            note.kodeButir!.startsWith('V.')) {
          _akPenunjangTerkumpul += note.angkaKredit;
        } else {
          _akUtamaTerkumpul += note.angkaKredit;
        }
      }
      notifyListeners();
    } else {
      _notes = await dbHelper.getNoteByKey(_searchKey);
    }
    return _notes;
  }

  set setQuery(String key) {
    _searchKey = key;
    notifyListeners();
  }

  set orderByKodeButir(bool val) {
    _orderByKodeButir = val;
  }

  void addNewNote(Note note) async {
    await dbHelper.saveNote(note);
    notifyListeners();
  }

  void updateNote(Note note) async {
    await dbHelper.updateNote(note);
    notifyListeners();
  }

  void deleteNote(int noteId) async {
    await dbHelper.deleteNote(noteId);
    notifyListeners();
  }

  void deleteAllNotes() async {
    await dbHelper.deleteAllNotes();
    notifyListeners();
  }

  void exportNotes(DocFile file) async {
    await dbHelper.saveExportNote(file);
    notifyListeners();
  }

  void deleteExcelFiles(int idFile) async {
    await dbHelper.deleteExportNote(idFile);
    notifyListeners();
  }
}
