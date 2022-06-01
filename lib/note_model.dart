
import 'package:flutter/material.dart';



class NoteFields{
  static final String? tableName = 'Note';
  static final String? id = '_id';
  static final String? title = 'title';
  static final String? desc = 'description';
}



class Note {
  int? id;
  String? title;
  String? desc;

  Note({this.id, required this.title, required this.desc});

  factory Note.fromMap(Map<String, dynamic> json) =>
      new Note(
        id: json[NoteFields.id],
        title: json[NoteFields.title],
        desc: json[NoteFields.desc],
      );

  Map<String, dynamic> toMap() {
    return {
      NoteFields.id!: id,
      NoteFields.title!: title,
      NoteFields.desc!: desc,
    };
  }
}