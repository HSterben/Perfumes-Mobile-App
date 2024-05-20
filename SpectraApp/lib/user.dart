class User {
  final String? id;
  final String? email;
  final String? password;

  User({
    this.id,
    required this.password,
    required this.email,
  });

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        password = map['password'],
        email = map['email'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }
}
