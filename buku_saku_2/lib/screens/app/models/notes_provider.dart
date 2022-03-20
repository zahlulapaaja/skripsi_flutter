import 'package:flutter/cupertino.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/database.dart';

class NotesProvider with ChangeNotifier {
  //List of note
  List<Note> _notes = [];
  var dbHelper = DbHelper();

  Future<List<Note>> get notes async {
    _notes = await dbHelper.getNotes();
    return _notes;
  }

  void addNewNote(note) async {
    await dbHelper.saveNote(note);
    notifyListeners();
  }

  void deleteNote(int noteId) async {
    await dbHelper.deleteNote(noteId);
    notifyListeners();
  }
}
