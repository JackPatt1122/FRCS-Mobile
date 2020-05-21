import 'package:bloc_login/database/user_database.dart';

class User {
  int id;
  String username;
  String token;

  User(
      {this.id,
      this.username,
      this.token});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
      id: data['id'],
      username: data['username'],
      token: data['token'],
  );

  Map<String, dynamic> toDatabaseJson() {
    var map = <String, dynamic>{
        DatabaseProvider.COLUMN_ID: id,
        DatabaseProvider.COLUMN_USERNAME: username,
        DatabaseProvider.COLUMN_TOKEN: token
      };

      return map;

      }
}
