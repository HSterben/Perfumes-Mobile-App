import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'perfume.dart';
import 'add.dart';
import 'view_perfume.dart';

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
      body: ListView.separated(
        itemCount: perfumes.length,
        separatorBuilder: (context, index) => Divider(color: Colors.grey),
        itemBuilder: (context, index) {
          return ListTile(
            // leading: Image.network(
            //   perfumes[index].imageUrl,
            //   width: 20,
            //   height: 20,
            //   fit: BoxFit.cover,
            // ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${perfumes[index].brand} ${perfumes[index].name}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${perfumes[index].perfumeNumber}'),
                    ],
                  ),
                ),
                Text(
                  '\$${perfumes[index].price?.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ViewProductPage(perfume: perfumes[index])),
              // );
            },
          );
        },
      ),
    );
  }
}
