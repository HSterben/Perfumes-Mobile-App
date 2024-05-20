class Perfume {
  String? id;
  String? brand;
  String? name;
  String? perfumeNumber;
  double? price;
  String imageUrl;
  int? quantity;

  Perfume({
    this.id,
    required this.brand,
    required this.name,
    required this.perfumeNumber,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  Perfume.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        brand = map['brand'],
        name = map['name'],
        perfumeNumber = map['perfume_number'],
        price = map['price'],
        imageUrl = map['imageUrl'],
        quantity = map['quantity'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'name': name,
      'perfume_number': perfumeNumber,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}
