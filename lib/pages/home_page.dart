import 'package:flutter/material.dart';
import 'package:flutter_notes_app/pages/detail_page.dart';
import 'package:flutter_notes_app/pages/form_page.dart';
import 'package:flutter_notes_app/utils/notes_database.dart';
import 'package:flutter_notes_app/widgets/card_widget.dart';

import '../models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note(
      id: 1,
      title: "Bensin",
      description: "Ke Makassar habis 2 juta",
      time: DateTime.now(),
    ),
    Note(
      id: 1,
      title: "Futsal",
      description: "Main Futsal di Lapangan 7 Futsal",
      time: DateTime.now(),
    ),
    Note(
      id: 1,
      title: "Ngoding",
      description: "Minimal ngoding sehari 6 jam",
      time: DateTime.now(),
    ),
    Note(
      id: 1,
      title: "Kerja",
      description: "Kerja Keras Bagai Kuda",
      time: DateTime.now(),
    ),
  ];

  bool isLoading = false;

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    NotesDatabase.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Catatan'),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailPage(note: notes[index]);
                          },
                        ),
                      );

                      refreshNotes();
                    },
                    child: CardWidget(
                      index: index,
                      note: notes[index],
                    ),
                  );
                },
                itemCount: notes.length,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.blue.shade300,
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return const FormPage();
          }));
          refreshNotes();
        },
        child: const Icon(
          Icons.note_add,
          color: Colors.white,
        ),
      ),
    );
  }
}
