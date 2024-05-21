import 'package:flutter/material.dart';
import 'perfume.dart';

class DetailedScreen extends StatelessWidget {
  final Perfume perfume;

  DetailedScreen({required this.perfume});

  @override
  Widget build(BuildContext context) {
    String perfumeName = perfume.name ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(perfumeName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(perfume.imageUrl),
            Text(perfumeName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(perfume.brand ?? ''),
            Text('Number: ${perfume.perfumeNumber ?? ''}'),
            Text('\$${perfume.price?.toStringAsFixed(2) ?? ''}', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
