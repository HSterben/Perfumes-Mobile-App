import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'models.dart';
import 'cart.dart';
import 'perfume_detail.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final dbHelper = DatabaseHelper.instance;
  List<Perfume> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  _loadCartItems() async {
    final cartItemIds = Cart().items;
    final perfumeRows = await dbHelper.queryAllPerfumes();
    List<Perfume> allPerfumes = perfumeRows?.map((item) => Perfume.fromMap(item)).toList() ?? [];

    setState(() {
      cartItems = allPerfumes.where((perfume) => cartItemIds.contains(perfume.id)).toList();
    });
  }

  void _removeFromCart(int id) async {
    Cart().removeItem(id);
    _loadCartItems(); // Refresh the cart list after removing an item
  }

  void _navigateToDetail(Perfume perfume) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PerfumeDetailScreen(perfume: perfume),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Purchase Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: Image.network(
                        cartItems[index].imageUrl ?? 'https://picsum.photos/250?image=9',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItems[index].brand ?? 'Unknown',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            cartItems[index].name ?? 'Name',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            '${cartItems[index].number}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\$${double.parse(cartItems[index].price ?? '0').toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _removeFromCart(cartItems[index].id!);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        _navigateToDetail(cartItems[index]);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Total: \$${_calculateTotalPrice()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle checkout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Center(
                child: Text(
                  'Check out',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += double.parse(item.price!);
    }
    return total;
  }
}
