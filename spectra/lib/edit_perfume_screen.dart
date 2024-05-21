import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'models.dart';

class EditPerfumeScreen extends StatefulWidget {
  final Perfume perfume;
  EditPerfumeScreen({required this.perfume});

  @override
  _EditPerfumeScreenState createState() => _EditPerfumeScreenState();
}

class _EditPerfumeScreenState extends State<EditPerfumeScreen> {
  final dbHelper = DatabaseHelper.instance;
  late TextEditingController brandController;
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController priceController;
  late TextEditingController imageUrlController;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    brandController = TextEditingController(text: widget.perfume.brand);
    nameController = TextEditingController(text: widget.perfume.name);
    numberController = TextEditingController(text: widget.perfume.number);
    priceController = TextEditingController(text: widget.perfume.price);
    imageUrlController = TextEditingController(text: widget.perfume.imageUrl);
    quantityController = TextEditingController(text: widget.perfume.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Perfume'),
      ),
      body: SingleChildScrollView(
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
              onPressed: _updatePerfume,
              child: Text('Update Perfume'),
            ),
          ],
        ),
      ),
    );
  }

  void _updatePerfume() async {
    final brand = brandController.text;
    final name = nameController.text;
    final number = numberController.text;
    final price = priceController.text;
    String Url = imageUrlController.text;
    final imageUrl = (Url == "") ? "https://img.freepik.com/premium-vector/vector-hand-drawn-perfume-outline-doodle-icon-perfume-sketch-illustration-print-web-mobile-infographics-isolated-white-background_107173-17476.jpg" : Url;
    final quantity = quantityController.text;

    Perfume updatedPerfume = Perfume(
      id: widget.perfume.id,
      brand: brand,
      name: name,
      number: number,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity,
    );

    await dbHelper.updatePerfume(updatedPerfume);
    Navigator.pop(context, true); // Pass true to indicate a perfume was updated
  }
}
