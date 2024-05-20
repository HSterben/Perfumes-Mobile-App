import 'dbhelper.dart';

class User {
  final int? id;
  final String? username;
  final String? password;
  final String? email;

  User(
      {this.id, required this.username, required this.password, required this.email});

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        password = map['password'],
        email = map['email'];

  Map<String, dynamic> toMap() {
    return {
      DBHelper.userId: id,
      DBHelper.username: username,
      DBHelper.userEmail: email,
      DBHelper.userPassword: password
    };
  }
}
