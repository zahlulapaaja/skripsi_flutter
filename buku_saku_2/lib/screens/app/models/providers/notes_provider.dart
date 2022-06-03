import 'package:flutter/cupertino.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  String _searchKey = '';
  var dbHelper = DbHelper();

  Future<List<Note>> get notes async {
    (_searchKey == '')
        ? _notes = await dbHelper.getNotes()
        : _notes = await dbHelper.getNoteByKey(_searchKey);
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
