import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practice/add_notes.dart';
import 'package:sqlite_practice/database_helper.dart';
import 'package:sqlite_practice/note_model.dart';
import 'package:sqlite_practice/screens/home.dart';
import 'package:sqlite_practice/screens/login_screen.dart';
import 'package:sqlite_practice/screens/registration_screen.dart';
import 'package:sqlite_practice/user_model.dart';
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
      initialRoute: '/login_screen',
      routes: {
        '/login_screen': (context) => LoginScreen(),
        '/registration_screen': (context) => RegistrationScreen(),
        '/home': (context) => MyHomePage(userId: 0,),
      },
    );
  }
}
