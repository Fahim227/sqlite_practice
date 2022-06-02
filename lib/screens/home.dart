import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practice/add_notes.dart';
import 'package:sqlite_practice/database_helper.dart';
import 'package:sqlite_practice/note_model.dart';
import 'package:sqlite_practice/user_model.dart';

class MyHomePage extends StatefulWidget {
  final int userId;
  MyHomePage({required this.userId});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Database? _database;
  DatabaseHelper? DBHelper;
  List<Note>? allNotes;
  void _createDB() async {
    DBHelper = await DatabaseHelper.instance;
    _database = await DBHelper!.database;
    print('Database version: ');
    print(await _database!.getVersion());
    // int response = await DatabaseHelper.instance.addNote(Note(title: 'Testing From App', desc: 'Checking is data inserting or not'));
    // print(response);
    // DatabaseHelper.instance.getNotes();
  }

  void getAllNotes(int userId) async {
    allNotes = await DatabaseHelper.instance.getNotes(userId);
  }

  @override
  void initState() {
    super.initState();
    _createDB();

    //print(_database!.isOpen);
    getAllNotes(widget.userId);
    //print(allNotes!.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container(
              width: double.infinity,
              child: FutureBuilder<List<Note>>(
                  future: DatabaseHelper.instance.getNotes(widget.userId),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Note>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Loading...'));
                    }
                    print(snapshot.data);
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int idx){
                        return Center(
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute<void>(
                                // Action 0 => update, Action 1 => save
                                builder: (BuildContext context) =>  AddOrUpdateNote(action: 0,note: snapshot.data![idx],userId: widget.userId,),
                              ),);
                            },
                            onLongPress: () async {
                              int res = await DatabaseHelper.instance.deleteNote(snapshot.data![idx].id!);
                              print(res);
                              setState((){});

                            },
                            title: Text(snapshot.data![idx].title == null ? 'Null': snapshot.data![idx].title!),
                          ),
                        );
                      },
                      // children: [
                      // Center(
                      // child: ListTile(
                      // title: Text(snapshot.data['title']),
                      // ),
                      // );
                      //   ]
                    );
                  }),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          // int val = await DatabaseHelper.instance.addUser(User(username: 'Fahim227', password: '1234'));
          // print('User id: $val');
          Navigator.push(context, MaterialPageRoute<void>(
            // Action 0 => update, Action 1 => save
            builder: (BuildContext context) =>  AddOrUpdateNote(action: 1,note: Note(title: '',desc: ''),userId: widget.userId),
          ),);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
