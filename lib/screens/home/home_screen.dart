import 'package:dairy/provider/notes/notes_provider.dart';
import 'package:dairy/repositiory/notes_repository.dart';
import 'package:dairy/screens/add_note/add_note_screen.dart';
import 'package:dairy/screens/home/widgets/item_note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Diary'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()=>setState(() {}), icon: const Icon(Icons.refresh))
        ],
      ),
      body: Consumer<NotesProvider>(builder: (context,provider,child){
        return provider.notes.isEmpty?const Center(child: Text('Empty'),): ListView(
          children: provider.notes.map((e)=>ItemNote(note: e)).toList(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddNoteScreen()));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
