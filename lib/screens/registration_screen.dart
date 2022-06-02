
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practice/constraints.dart';
import 'package:sqlite_practice/database_helper.dart';
import 'package:sqlite_practice/rounded_button.dart';
import 'package:sqlite_practice/screens/login_screen.dart';
import 'package:sqlite_practice/user_model.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = '/registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String username='';
  String password='';
  bool _inProgess = false;
  int _counter = 0;
  Database? _database;
  DatabaseHelper? DBHelper;
  void _createDB() async {
    DBHelper = await DatabaseHelper.instance;
    _database = await DBHelper!.database;
  }


  @override
  void initState() {
    super.initState();
    _createDB();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _inProgess,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Registration'),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,

                onChanged: (value) {
                  //Do something with the user input.
                  username = value;
                },
                decoration: kInputDecorations.copyWith(
                    hintText: 'Enter Your UserName.'
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kInputDecorations.copyWith(
                  hintText: 'Enter Your Password.'
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.blue,
                onPress: () async {
                  setState((){
                    _inProgess = true;
                  });
                  int id = await DatabaseHelper.instance.addUser(User(username: username, password: password));
                  print(id);
                  try{
                    if(id != null){
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                    setState((){
                      _inProgess = false;
                    });
                  }
                  catch (e){
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
