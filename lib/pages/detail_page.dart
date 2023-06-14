// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_notes_app/pages/form_pagea.dart';
import 'package:flutter_notes_app/utils/notes_database.dart';

import '../models/note.dart';

class DetailPage extends StatefulWidget {
  final Note note;

  const DetailPage({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Note note;

  Future refreshNote() async {
    note = await NotesDatabase.instance.readNote(widget.note.id!);
    setState(() {});
  }

  @override
  void initState() {
    note = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          InkWell(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return FormPage(
                    note: widget.note,
                  );
                }),
              );
              refreshNote();
            },
            child: Icon(Icons.edit_note),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.delete),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListView(
          children: [
            Text(
              note.title,
              style: TextStyle(
                color: Colors.blue.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              note.description,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
