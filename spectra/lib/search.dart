import 'package:flutter/material.dart';
import 'models.dart';
import 'dbhelper.dart';
import 'add_perfume_screen.dart';
import 'edit_perfume_screen.dart';
import 'perfume_detail.dart';
import 'cart.dart';

class MySearchPage extends StatefulWidget {
  final bool isAdmin;
  MySearchPage({required this.isAdmin}); // receive the isAdmin flag

  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  final dbHelper = DatabaseHelper.instance;
  List<Perfume> perfumes = [];
  TextEditingController _searchController = TextEditingController();

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

  void _searchPerfumes(String query) async {
    final allRows = await dbHelper.queryPerfume(query);
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
        title: Text('Search Perfume'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search icon press
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
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter perfume name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                _searchPerfumes(value);
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: perfumes.length,
              separatorBuilder: (context, index) => Divider(color: Colors.grey),
              itemBuilder: (context, index) {
                return ListTile(
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
                            Text('${perfumes[index].number}'),
                          ],
                        ),
                      ),
                      Text(
                        '\$${perfumes[index].price}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () => _navigateToDetail(perfumes[index]),
                  trailing: widget.isAdmin
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPerfumeScreen(perfume: perfumes[index]),
                            ),
                          );

                          if (result == true) {
                            _queryAll(); // Refresh the list after updating a perfume
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deletePerfume(perfumes[index].id);
                        },
                      ),
                    ],
                  )
                      : null,
                );
              },
            ),
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
