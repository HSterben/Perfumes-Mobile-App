import 'dbhelper.dart';

class Perfume {
  int? id;
  String? brand;
  String? name;
  String? perfumeNumber;
  double? price;
  String? imageUrl;
  int? quantity;

  Perfume({
    required this.id,
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
      DBHelper.columnId: id,
      DBHelper.columnBrand: brand,
      DBHelper.columnName: name,
      DBHelper.columnPerfumeNumber: perfumeNumber,
      DBHelper.columnPrice: price,
      DBHelper.columnImageUrl: imageUrl,
      DBHelper.columnQuantity: quantity,
    };
  }
}
