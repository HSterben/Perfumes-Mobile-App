class Perfume {
  int? id;
  String title;
  String brand;
  double price;
  String imageUrl;
  int quantity;

  Perfume({
    this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  Perfume.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        brand = map['brand'],
        price = map['price'],
        imageUrl = map['imageUrl'],
        quantity = map['quantity'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'brand': brand,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}
