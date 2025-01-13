import 'package:dairy/models/note.dart';
import 'package:dairy/repositiory/notes_repository.dart';
import 'package:flutter/cupertino.dart';

class NotesProvider with ChangeNotifier {

  List<Note> notes = [];

  NotesProvider(){
    getNotes();
  }

  getNotes()async{
    notes = await NotesRepository.getNotes();
    notifyListeners();
  }

  Future<bool> insert({required Note note})async{
    await NotesRepository.insert(note: note);
    getNotes();
    return true;
  }

  Future<bool> update({required Note note})async{
    await NotesRepository.update(note: note);
    getNotes();
    return true;
  }

  Future<bool> delete({required Note note})async{
    await NotesRepository.delete(note: note);
    getNotes();
    return true;
  }




}