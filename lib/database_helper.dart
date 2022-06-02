import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practice/note_model.dart';
import 'package:sqlite_practice/relational_user_note_model.dart';
import 'package:sqlite_practice/user_model.dart';

class DatabaseHelper{
  // Make a Singleton instance of DatabaseHelper
  // the singleton pattern is a software design pattern that,
  // restricts the instantiation of a class to one "single" instance.
  // This is useful when exactly one object is needed to coordinate actions across the system.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Initialize the database name
  // and define a Database instance
  static String dbName = 'myDB.db';
  static Database? _database;


  Future<Database?> get database async {
    if(_database != null){
      return _database;
    }
    print('Updating DB');
    _database = await _initDB();
    return _database;


  }

  Future<Database> _initDB() async {

    String directoryPath = await getDatabasesPath();
    String path = join(directoryPath,DatabaseHelper.dbName);

    print('Upgrading');
    return await openDatabase(path,version: 5,onCreate: _createDatabase,onUpgrade: (Database? db, int oldVersion, int newVersion) {
      print(newVersion);
      if (oldVersion < newVersion) {
        // you can execute drop table and create table
        _createRelationTable(db!);
      }
    } );
  }

  void _createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE ${NoteFields.tableName} (${NoteFields.id} INTEGER PRIMARY KEY, ${NoteFields.title} TEXT, ${NoteFields.desc} TEXT), ');
      }

  void _createUserTable(Database? db) async {
    await db!.execute(
        'CREATE TABLE ${UserFields.tableName} (${UserFields.id} INTEGER PRIMARY KEY, ${UserFields.username} TEXT, ${UserFields.password} TEXT)');
  }
  void _createRelationTable(Database? db) async {
    print('Relational DB');
    String query = "Create TABLE ${RelationUserNoteFields.tableName} (${RelationUserNoteFields.id} INTEGER PRIMARY KEY, ${RelationUserNoteFields.user_id} INTEGER, ${RelationUserNoteFields.note_id} INTEGER, FOREIGN KEY (${RelationUserNoteFields.user_id}) REFERENCES User(${UserFields.id}),FOREIGN KEY (${RelationUserNoteFields.note_id}) REFERENCES Note(${NoteFields.id}));";
    await db!.execute(query);

  }

  void _onUpgrade(Database? db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      // you can execute drop table and create table
      _createUserTable(db!);
      _createRelationTable(db!);
    }
  }

  //
  Future<List<Note>> getNotes() async {
    Database? db = await instance.database;
    var notes = await db!.query(NoteFields.tableName!);
    print(notes.length);
    List<Note> allNotes = notes.isNotEmpty ? notes.map((e) => Note.fromMap(e)).toList() : [];
    return allNotes;
  }

  Future<int> addNote(Note note) async {
    Database? db = await DatabaseHelper.instance.database;
    return await db!.insert(NoteFields.tableName!, note.toMap());
  }

  Future<int> addUser(User user) async {
    Database? db = await DatabaseHelper.instance.database;
    return await db!.insert(UserFields.tableName!, user.toMap());
  }

  Future<int> deleteNote(int id) async{
    Database? db = await DatabaseHelper.instance.database;
    int response = await db!.delete(NoteFields.tableName!,where: '_id = ?', whereArgs: [id]);
    return response;
  }
  Future<int> updateNote(int id,Note note ) async {
    Database? db = await DatabaseHelper.instance.database;
    int response = await db!.update(NoteFields.tableName!,note.toMap(), where: '_id = ?',whereArgs: [id]);
    return response;
  }
}