import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'perfume.dart';
import 'add_edit_perfume.dart';

class ViewProductPage extends StatelessWidget {
  final Perfume perfume;

  ViewProductPage({required this.perfume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(perfume.title),
      ),
      body: ListView(
        children: <Widget>[
          Image.network(perfume.imageUrl),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  perfume.title,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  perfume.brand,
                  style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                ),
                Text('\$${perfume.price.toStringAsFixed(2)}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Quantity: ${perfume.quantity}'),
                    ElevatedButton(
                      onPressed: () {
                        // Add to cart functionality
                      },
                      child: Text('Add to Cart'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
