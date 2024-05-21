import 'package:http/http.dart' as http;
import 'dart:convert';

class Perfume {
  int? id;
  String? brand;
  String? name;
  String? number;
  String? price;
  String? imageUrl;
  String? quantity;

  Perfume({
    this.id,
    required this.brand,
    required this.name,
    required this.number,
    required this.price,
    this.imageUrl,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'name': name,
      'number': number,
      'price': price,
      'image': imageUrl,
      'quantity': quantity,
    };
  }

  factory Perfume.fromMap(Map<String, dynamic> map) {
    return Perfume(
      id: map['id'],
      brand: map['brand'],
      name: map['name'],
      number: map['number'],
      price: map['price'],
      imageUrl: map['image'],
      quantity: map['quantity'],
    );
  }
}


class User {
  int? id;
  String? password;
  String? email;

  User({
    this.id,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      password: map['password'],
      email: map['email'],
    );
  }
}
List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  int postId;
  int id;
  String name;
  String email;
  String body;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    postId: json["postId"],
    id: json["id"],
    name: json["name"],
    email: json["email"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "id": id,
    "name": name,
    "email": email,
    "body": body,
  };
}