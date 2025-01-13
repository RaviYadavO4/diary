import 'package:dairy/models/note.dart';
import 'package:dairy/provider/notes/notes_provider.dart';
import 'package:dairy/repositiory/notes_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _title.text = widget.note!.title;
      _description.text = widget.note!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        actions: [
          widget.note != null
              ? IconButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context)=>AlertDialog(
                      content: const Text('Are you sure you want to delete this note'),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: const Text('No')),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                          _deleteNote();
                        }, child: const Text('Yes')),
                      ],
                    ));
                  }, icon: const Icon(Icons.delete_outline))
              : const SizedBox(),
          IconButton(
              onPressed: widget.note == null ? _insertNote : _updateNote,
              icon: const Icon(Icons.done)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: TextField(
                controller: _description,
                decoration: InputDecoration(
                    hintText: 'Start typing here...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                maxLines: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _insertNote() async {
    final note = Note(title: _title.text, description: _description.text, createdAt: DateTime.now());
    Provider.of<NotesProvider>(context,listen: false).insert(note: note).then((isDone){
      Navigator.pop(context);
    });
  }

  _updateNote() async {
    final note = Note(
        id: widget.note!.id, title: _title.text, description: _description.text, createdAt: widget.note!.createdAt);
    Provider.of<NotesProvider>(context,listen: false).update(note: note).then((isDone){
      Navigator.pop(context);
    });
  }

  _deleteNote() async {
    Provider.of<NotesProvider>(context,listen: false).delete(note: widget.note!).then((isDone){
      Navigator.pop(context);
    });
  }
}
