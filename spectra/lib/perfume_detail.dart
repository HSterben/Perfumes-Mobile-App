import 'package:flutter/material.dart';
import 'models.dart';
import 'dbhelper.dart';

class PerfumeDetailScreen extends StatelessWidget {
  final Perfume perfume;
  final dbHelper = DatabaseHelper.instance;

  PerfumeDetailScreen({required this.perfume});

  void _addToCart(Perfume perfume) async {
    await dbHelper.insertCartItem(perfume);
    print('${perfume.name} added to cart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${perfume.brand} ${perfume.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            perfume.imageUrl != null
                ? Image.network(perfume.imageUrl!)
                : Container(),
            SizedBox(height: 10),
            Text(
              '${perfume.brand} ${perfume.name}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Number: ${perfume.number}'),
            Text('Price: \$${perfume.price}'),
            Text('Quantity: ${perfume.quantity}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addToCart(perfume),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
