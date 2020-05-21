import 'dart:async';
import 'dart:io';

import 'package:bloc_login/model/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';




final userTable = 'userTable';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  static const String COLUMN_ID = "id";
  static const String COLUMN_USERNAME = "username";
  static const String COLUMN_TOKEN = 'token';

   Database _database;

  Future <Database> get database async {
    if (_database != null){
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }





  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "User.db");

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  void onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ){
    if (newVersion > oldVersion){}
  }

  void initDB(Database database, int version) async {
    await database.execute(
      "CREATE TABLE $userTable ("
      "$COLUMN_ID INTEGER PRIMARY KEY, "
      "$COLUMN_USERNAME TEXT, "
      "$COLUMN_TOKEN TEXT "
      ")"
    );
  }

  Future<List<User>> getToken() async {
    final db = await database;

    var token = await db.query('userTable',
    columns: [COLUMN_USERNAME, COLUMN_TOKEN]
    
    );
    
    List<User> userList = List<User>();

    token.forEach((currentToken) { 
      User user = User.fromDatabaseJson(currentToken);

      print(user);


    });
    print(userList);
    return userList;
  }

  
}

