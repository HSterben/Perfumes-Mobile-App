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