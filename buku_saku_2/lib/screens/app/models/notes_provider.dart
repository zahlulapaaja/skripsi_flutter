import 'package:flutter/cupertino.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/database.dart';

class NotesProvider with ChangeNotifier {
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

  // Ini tentang newNoteForm
  final List<String> _jenjang = [
    'Pranata Komputer Terampil',
    'Pranata Komputer Mahir',
    'Pranata Komputer Penyelia',
    'Pranata Komputer Ahli Pertama',
    'Pranata Komputer Ahli Muda',
    'Pranata Komputer Ahli Madya',
    'Pranata Komputer Ahli Utama',
  ];

  List<String> get jenjang => _jenjang;
}
