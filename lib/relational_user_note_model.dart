
import 'package:flutter/material.dart';



class RelationUserNoteFields{
  static final String? tableName = 'RelationUserNote';
  static final String? id = '_id';
  static final String? user_id = 'user_id';
  static final String? note_id = 'note_id';
}



class RelationUserNote {
  int? id;
  int? user_id;
  int? note_id;

  RelationUserNote({this.id, required this.user_id, required this.note_id});

  factory RelationUserNote.fromMap(Map<String, dynamic> json) =>
      RelationUserNote(
        id: json[RelationUserNoteFields.id],
        user_id: json[RelationUserNoteFields.user_id],
        note_id: json[RelationUserNoteFields.note_id],
      );

  Map<String, dynamic> toMap() {
    return {
      RelationUserNoteFields.id!: id,
      RelationUserNoteFields.user_id!: user_id,
      RelationUserNoteFields.note_id!: note_id,
    };
  }
}