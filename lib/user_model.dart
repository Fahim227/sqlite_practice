
import 'package:flutter/material.dart';



class UserFields{
  static final String? tableName = 'User';
  static final String? id = '_id';
  static final String? username = 'username';
  static final String? password = 'password';
}



class User {
  int? id;
  String? username;
  String? password;

  User({this.id, required this.username, required this.password});

  factory User.fromMap(Map<String, dynamic> json) =>
       User(
        id: json[UserFields.id],
        username: json[UserFields.username],
        password: json[UserFields.password],
      );

  Map<String, dynamic> toMap() {
    return {
      UserFields.id!: id,
      UserFields.username!: username,
      UserFields.password!: password,
    };
  }
}