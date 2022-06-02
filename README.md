# sqlite_practice

A Note App with Authentication.

## Getting Started

This App is Created Based on this below diagram.

![alt text](https://github.com/Fahim227/sqlite_practice/blob/master/Untitled%20Diagram.drawio.png?raw=true)

SQLite is a C-language library that provides a SQL database engine that is tiny,
fast, self-contained, high-reliability, and full-featured. 
The SQLite database engine is the most widely used database engine on the planet.
SQLite is included in all mobile phones and most laptops, as well as a slew of other programs that people use on a daily basis.

To use SQLite her the SQflite plugin used in this app

Operations:
    * User can create account
    * Login
    * Add, Delete, Update and show Notes
Each User's Notes are shown based on their PrimaryKey(PK) and saved their Notes in RelationUserNote table using user_id and note_id.
The Data is stored in the devices local database.