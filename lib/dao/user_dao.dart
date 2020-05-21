import 'package:bloc_login/database/user_database.dart';
import 'package:bloc_login/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';


class UserDao {

  
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());

    
    return result;
  }



  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db
        .delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users = await db
          .query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future getToken(int id) async {
    final db = await dbProvider.database;

    
      List<Map> users = await db.query(userTable, where: 'id= ?', whereArgs: [id]);
      return Future.value(users[0]['token']);
    
  }
  

    tokenString() async {
    final val = await getToken(0);
    }

  Future getUser(int id) async {
    final db = await dbProvider.database;

    
      List<Map> users = await db.query(userTable, where: 'id= ?', whereArgs: [id]);
      return Future.value(users[0]['username']);
    
  }
  

    userString() async {
    final val = await getUser(0);
    }

}



