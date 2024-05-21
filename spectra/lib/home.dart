import 'package:flutter/material.dart';
import 'models.dart';
import 'dbhelper.dart';
import 'perfume_detail.dart';
import 'add_perfume_screen.dart'; // import add perfume screen
import 'edit_perfume_screen.dart'; // import edit perfume screen

class MyHomePage extends StatefulWidget {
  final bool isAdmin;
  MyHomePage({required this.isAdmin}); // receive the isAdmin flag

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;
  List<Perfume> perfumes = [];

  @override
  void initState() {
    super.initState();
    _queryAll();
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllPerfumes();
    perfumes.clear();
    allRows?.forEach((row) => perfumes.add(Perfume.fromMap(row)));
    setState(() {});
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
        title: Text('Order Now'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPerfumeScreen()),
              ).then((_) {
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
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Image.network(
                perfumes[index].imageUrl ?? 'https://picsum.photos/250?image=9', // Add your image path here
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    perfumes[index].brand ?? 'Unknown',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    perfumes[index].name ?? 'Name',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    '${perfumes[index].number}', // Adjust according to your data
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                '\$${double.parse(perfumes[index].price ?? '0').toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PerfumeDetailScreen(perfume: perfumes[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _deletePerfume(int? id) async {
    if (id != null) {
      await dbHelper.deletePerfume(id);
      _queryAll(); // Refresh the list after deleting a perfume
    }
  }
}
