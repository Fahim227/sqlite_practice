
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_practice/constraints.dart';
import 'package:sqlite_practice/database_helper.dart';
import 'package:sqlite_practice/rounded_button.dart';
import 'package:sqlite_practice/screens/home.dart';
import 'package:sqlite_practice/screens/registration_screen.dart';
import 'package:sqlite_practice/user_model.dart';
class LoginScreen extends StatefulWidget {
  static String id = '/login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  String username='';
  String password='';
  bool _inProgess = false;
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
        color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Log in',),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  username = value;
                },
                decoration: kInputDecorations.copyWith(
                  hintText: 'Enter Your Email.'
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black),
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
                title: 'Log In',
                color: Colors.lightBlue,
                onPress: () async {
                  setState((){
                    _inProgess = true;
                  });
                  try{
                    print(username+' '+password);
                    int id = await  DatabaseHelper.instance.authenticateUser(User(username: username, password: password));
                    print(id);
                    if(id != 0 ){
                      Navigator.push(context, MaterialPageRoute(builder:  (context) =>  MyHomePage(userId: id)));
                    }
                    setState((){
                      _inProgess = false;
                    });
                  }
                  catch(e){
                    print(e);
                  }
                },
              ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
            child: new Text("No Account? Click to Register!"),
          )
            ],
          ),
        ),
      ),
    );
  }
}
