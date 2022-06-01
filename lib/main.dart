import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practice/add_notes.dart';
import 'package:sqlite_practice/database_helper.dart';
import 'package:sqlite_practice/note_model.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

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
    // int response = await DatabaseHelper.instance.addNote(Note(title: 'Testing From App', desc: 'Checking is data inserting or not'));
    // print(response);
    // DatabaseHelper.instance.getNotes();
  }

  void getAllNotes() async {
    allNotes = await DatabaseHelper.instance.getNotes();
  }

  @override
  void initState() {
    super.initState();
    _createDB();
    //print(_database!.isOpen);
    getAllNotes();
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
                  future: DatabaseHelper.instance.getNotes(),
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
                                  builder: (BuildContext context) =>  AddOrUpdateNote(action: 0,note: snapshot.data![idx],),
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
        onPressed: (){
          Navigator.push(context, MaterialPageRoute<void>(
            // Action 0 => update, Action 1 => save
            builder: (BuildContext context) =>  AddOrUpdateNote(action: 1,note: Note(title: '',desc: ''),),
          ),);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
