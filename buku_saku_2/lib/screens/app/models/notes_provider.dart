import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/database.dart';
import 'package:flutter/cupertino.dart';

class NotesProvider with ChangeNotifier {
  //List of note
  List<Note> _notes = [];
  var dbHelper = DbHelper();

  Note _noteOne = Note(title: 'Hagudu', body: 'Japan');
  Note get noteOne => _noteOne;

  void addingNotes(newNote) async {
    await dbHelper.saveNote(newNote);

    // _noteOne = _noteOne;
    //_userTwo = userTwo;
    //_userThree = userThree;

    notifyListeners();
  }

  Future<List<Note>> get notes async {
    _notes = await dbHelper.getNotes();
    return _notes;

    // _noteOne = _noteOne;
    //_userTwo = userTwo;
    //_userThree = userThree;

    // notifyListeners();
  }

  // NotesOperation() {
  //   addNewNote('First Note', 'First Note Description');
  // }

  void addNewNote(String title, String description) async {
    //Note object
    Note note = Note(title: title, body: description);
    _notes.add(note);
    final newNote = Note(
      title: 'judullll',
      body: 'uraiannnnnn',
    );

    print('oiii');

    // klo cuma pop datanya jadi ga keload
    await dbHelper.saveNote(newNote);
    notifyListeners();
  }

  void deleteNote(int noteId) async {
    //Note object

    // klo cuma pop datanya jadi ga keload
    await dbHelper.deleteNote(noteId);
    notifyListeners();
  }

//   Future<List<Note>> getNotes() async {
//     //Note object
//     // Note note = Note(title: title, body: description);
//     _notes = await dbHelper.getNotes();
//
//     print('oiii');
//
// return _notes;
//     notifyListeners();
//   }
}
