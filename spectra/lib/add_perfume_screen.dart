import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'models.dart';

class AddPerfumeScreen extends StatefulWidget {
  @override
  _AddPerfumeScreenState createState() => _AddPerfumeScreenState();
}

class _AddPerfumeScreenState extends State<AddPerfumeScreen> {
  final dbHelper = DatabaseHelper.instance;
  final TextEditingController brandController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Perfume'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: brandController,
              decoration: InputDecoration(labelText: 'Brand'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: numberController,
              decoration: InputDecoration(labelText: 'Number'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPerfume,
              child: Text('Add Perfume'),
            ),
          ],
        ),
      ),
    );
  }

  void _addPerfume() async {
    final brand = brandController.text;
    final name = nameController.text;
    final number = numberController.text;
    final price = priceController.text;
    String Url = imageUrlController.text;
    final imageUrl = (Url == "") ? "https://img.freepik.com/premium-vector/vector-hand-drawn-perfume-outline-doodle-icon-perfume-sketch-illustration-print-web-mobile-infographics-isolated-white-background_107173-17476.jpg" : Url;
    final quantity = quantityController.text;

    Perfume perfume = Perfume(
      brand: brand,
      name: name,
      number: number,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity,
    );

    await dbHelper.insertPerfume(perfume);
    Navigator.pop(context, true); // Pass true to indicate a new perfume was added
  }
}
