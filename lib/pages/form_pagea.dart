// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_notes_app/utils/notes_database.dart';

import '../models/note.dart';

class FormPage extends StatefulWidget {
  final Note? note;
  const FormPage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descController.text = widget.note!.description;
    }
    super.initState();
  }

  Future updateNote() async {
    final note = widget.note!.copyWith(
      title: titleController.text,
      description: descController.text,
    );

    await NotesDatabase.instance.update(note);
    Navigator.of(context).pop();
  }

  Future addNote() async {
    final note = Note(
      title: titleController.text,
      description: descController.text,
      time: DateTime.now(),
    );

    // print(titleController.text);

    await NotesDatabase.instance.create(note);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form',
        ),
        actions: [
          InkWell(
            onTap: () {
              if (widget.note != null) {
                updateNote();
              } else {
                addNote();
              }
            },
            child: const Icon(Icons.save),
          ),
          const SizedBox(
            width: 18,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            TextFormField(
              controller: titleController,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: descController,
              maxLines: 16,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                hintText: 'Catatan...',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
