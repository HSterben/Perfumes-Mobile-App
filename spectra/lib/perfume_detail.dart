import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';
import 'dbhelper.dart';
<<<<<<< Updated upstream
import 'ApiService.dart';
=======
import 'cart.dart';
>>>>>>> Stashed changes

class PerfumeDetailScreen extends StatefulWidget {
  final Perfume perfume;

  PerfumeDetailScreen({required this.perfume});

<<<<<<< Updated upstream
  @override
  _PerfumeDetailScreenState createState() => _PerfumeDetailScreenState();
}

class _PerfumeDetailScreenState extends State<PerfumeDetailScreen> {
  final dbHelper = DatabaseHelper.instance;
  late Future<List<Comment>?> comments;

  @override
  void initState() {
    super.initState();
    comments = ApiService().getComments();
  }

  void _addToCart(Perfume perfume) async {
    await dbHelper.insertCartItem(perfume);
=======
  void _addToCart(int perfumeId) async {
    Cart().addItem(perfumeId);
>>>>>>> Stashed changes
    print('${perfume.name} added to cart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.perfume.brand} ${widget.perfume.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.perfume.imageUrl != null
                ? Image.network(width: 350, height: 350, widget.perfume.imageUrl!)
                : Container(),
            SizedBox(height: 10),
            Text(
              '${widget.perfume.brand} ${widget.perfume.name}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Number: ${widget.perfume.number}'),
            Text('Price: \$${widget.perfume.price}'),
            Text('Quantity: ${widget.perfume.quantity}'),
            SizedBox(height: 20),
            ElevatedButton(
<<<<<<< Updated upstream
              onPressed: () => _addToCart(widget.perfume),
=======
              onPressed: () => _addToCart(perfume.id!),
>>>>>>> Stashed changes
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
            Expanded(
              child: FutureBuilder<List<Comment>?>(
                future: comments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Text("No comments found");
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Comment comment = snapshot.data![index];
                        return ListTile(
                          title: Text(comment.name),
                          subtitle: Text(comment.body),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
