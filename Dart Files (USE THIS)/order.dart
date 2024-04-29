import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'perfume.dart';
import 'add.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DBHelper.instance;
  List<Perfume> perfumes = [];

  @override
  void initState() {
    super.initState();
    _queryAll();
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    perfumes.clear();
    allRows?.forEach((row) => perfumes.add(Perfume.fromMap(row)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Now'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePageADD()),
              ).then((_) {
                // This will be triggered when Navigator.pop() is called from MyHomePageADD
                _queryAll(); // Refresh the list after adding a new perfume
              });
            },
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: perfumes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(perfumes[index].imageUrl), // Assuming imageUrl is a network path
              title: Text('${perfumes[index].brand} ${perfumes[index].name}'),
              subtitle: Text('${perfumes[index].perfumeNumber}'),
              trailing: Text('\$${perfumes[index].price?.toStringAsFixed(2)}'),
            ),
          );
        },
      ),
    );
  }
}
