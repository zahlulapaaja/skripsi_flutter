import 'package:flutter/cupertino.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  String _searchKey = '';
  double _akUtamaTerkumpul = 0.0;
  double _akPenunjangTerkumpul = 0.0;
  var dbHelper = DbHelper();

  double get akUtamaTerkumpul => _akUtamaTerkumpul;
  double get akPenunjangTerkumpul => _akPenunjangTerkumpul;

  Future<List<Note>> get notes async {
    if (_searchKey == '') {
      _notes = await dbHelper.getNotes();
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
}
