import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practice/constraints.dart';
import 'package:sqlite_practice/database_helper.dart';
import 'package:sqlite_practice/main.dart';
import 'package:sqlite_practice/note_model.dart';
import 'package:sqlite_practice/rounded_button.dart';
import 'package:sqlite_practice/screens/home.dart';


class AddOrUpdateNote extends StatelessWidget {
  AddOrUpdateNote({Key? key,required this.action, required this.note,required this.userId}) : super(key: key);

  int action;
  int userId;
  Note note;
  String? title;
  String? desc;
  Database? _database;
  DatabaseHelper? DBHelper;

  void addNote(BuildContext context) async {
    Database? db = await DatabaseHelper.instance.database;
    Note note = Note(title: title, desc: desc);
    int response = await DatabaseHelper.instance.addNote(note,userId);
    print(response);
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) =>  MyHomePage(userId: userId,),
    ),);
  }

  void updateNote(BuildContext context) async {
    Database? db = await DatabaseHelper.instance.database;
    Note n = Note(id: note.id,title: title, desc: desc);
    print(n.title);
    int response = await DatabaseHelper.instance.updateNote(note.id!,  n);
    print(response);
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) =>  MyHomePage(userId: userId,),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Add Note'),),
        body: action == 1 ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                title = value;
              },
              decoration: kInputDecorations.copyWith(
                  hintText: 'Enter Your Note title.'
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                desc = value;
              },
              decoration: kInputDecorations.copyWith(
                  hintText: 'Enter Your note description.'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                title: 'Save',
                color: Colors.lightBlue,
                onPress: (){
                  addNote(context);
                }
            ),
          ],
        ) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: TextEditingController()..text = note.title!,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                title = value;
              },
              decoration: kInputDecorations.copyWith(

              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: TextEditingController()..text = note.desc!,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                desc = value;
              },
              decoration: kInputDecorations.copyWith(
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                title: 'Update',
                color: Colors.lightBlue,
                onPress: (){
                  print('$title $desc');
                  updateNote(context);
                }
            ),
          ],
        ),
      ),
    );
  }
}
