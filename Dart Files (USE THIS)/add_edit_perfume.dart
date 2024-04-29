import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'perfume.dart';

class AddEditPerfumePage extends StatefulWidget {
  final Perfume? perfume; // Pass `null` if you're adding a new perfume.

  AddEditPerfumePage({this.perfume});

  @override
  _AddEditPerfumePageState createState() => _AddEditPerfumePageState();
}

class _AddEditPerfumePageState extends State<AddEditPerfumePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _brandController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.perfume?.title ?? '');
    _brandController = TextEditingController(text: widget.perfume?.brand ?? '');
    _priceController = TextEditingController(text: widget.perfume?.price.toString() ?? '');
    _imageUrlController = TextEditingController(text: widget.perfume?.imageUrl ?? '');
    _quantityController = TextEditingController(text: widget.perfume?.quantity.toString() ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _brandController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.perfume == null ? 'Add Perfume' : 'Edit Perfume'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
            ),
            TextFormField(
              controller: _brandController,
              decoration: InputDecoration(labelText: 'Brand'),
              validator: (value) => value!.isEmpty ? 'Please enter a brand name' : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Please enter a price' : null,
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
              validator: (value) => value!.isEmpty ? 'Please enter an image URL' : null,
            ),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Please enter the quantity' : null,
            ),
            ElevatedButton(
              onPressed: _onSubmit,
              child: Text(widget.perfume == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      Perfume newPerfume = Perfume(
        id: widget.perfume?.id, // keep the id if it's an update
        title: _titleController.text,
        brand: _brandController.text,
        price: double.parse(_priceController.text),
        imageUrl: _imageUrlController.text,
        quantity: int.parse(_quantityController.text),
      );

      if (widget.perfume == null) {
        // Adding a new perfume
        await DBHelper.instance.insert(newPerfume);
      } else {
        // Updating an existing perfume
        await DBHelper.instance.update(newPerfume);
      }

      // Close the screen and return to the previous page
      Navigator.of(context).pop(true);
    }
  }
}