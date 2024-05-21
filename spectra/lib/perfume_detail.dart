import 'package:flutter/material.dart';
import 'models.dart';

class PerfumeDetailScreen extends StatelessWidget {
  final Perfume perfume;

  PerfumeDetailScreen({required this.perfume});

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
            Text(
              '${perfume.brand} ${perfume.name}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Number: ${perfume.number}'),
            Text('Price: \$${perfume.price}'),
            Text('Quantity: ${perfume.quantity}'),
            SizedBox(height: 10),
            perfume.imageUrl != null
                ? Image.network(perfume.imageUrl!)
                : Container(),
          ],
        ),
      ),
    );
  }
}
