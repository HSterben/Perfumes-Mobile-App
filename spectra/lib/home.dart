import 'package:flutter/material.dart';
import 'models.dart';
import 'dbhelper.dart';
import 'perfume_detail.dart';
import 'add_perfume_screen.dart';
import 'edit_perfume_screen.dart';
import 'search.dart';
import 'cart_page.dart';

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
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MySearchPage(isAdmin: widget.isAdmin),
                ),
              );
            },
          ),
          if (widget.isAdmin)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPerfumeScreen()),
                );

                if (result == true) {
                  _queryAll(); // Refresh the list after adding a new perfume
                }
              },
            ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            itemCount: perfumes.length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey),
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Image.network(
                    perfumes[index].imageUrl ??
                        'https://picsum.photos/250?image=9',
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
                        '${perfumes[index].number}',
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
                      if (widget.isAdmin)
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditPerfumeScreen(perfume: perfumes[index]),
                              ),
                            );

                            if (result == true) {
                              _queryAll(); // Refresh the list after updating a perfume
                            }
                          },
                        ),
                      if (widget.isAdmin)
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deletePerfume(perfumes[index].id);
                          },
                        ),
                      Text(
                        '\$${double.parse(perfumes[index].price ?? '0').toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    _navigateToDetail(perfumes[index]);
                  },
                ),
              );
            },
          ),
        ],
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
