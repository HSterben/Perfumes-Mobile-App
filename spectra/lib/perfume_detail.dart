import 'package:flutter/material.dart';
import 'models.dart';
import 'dbhelper.dart';
import 'cart.dart';
import 'ApiService.dart';

class PerfumeDetailScreen extends StatefulWidget {
  final Perfume perfume;

  PerfumeDetailScreen({required this.perfume});

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

  void _addToCart(int perfumeId) async {
    Cart().addItem(perfumeId);
    print('${widget.perfume.name} added to cart');
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
                ? Image.network(
              widget.perfume.imageUrl!,
              width: 350,
              height: 350,
            )
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
              onPressed: () => _addToCart(widget.perfume.id!),
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
