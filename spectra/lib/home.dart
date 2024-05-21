import 'package:flutter/material.dart';
import 'models.dart';
import 'dbhelper.dart';
<<<<<<< Updated upstream
import 'perfume_detail.dart';
import 'add_perfume_screen.dart'; // import add perfume screen
import 'edit_perfume_screen.dart'; // import edit perfume screen
=======
import 'add_perfume_screen.dart';
import 'edit_perfume_screen.dart';
import 'perfume_detail.dart';
import 'search.dart';
>>>>>>> Stashed changes

class MyHomePage extends StatefulWidget {
  final bool isAdmin;

  MyHomePage({required this.isAdmin}); // receive the isAdmin flag

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
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
        actions: widget.isAdmin
            ? [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddPerfumeScreen()),
              );
              if (result == true) {
                _queryAll(); // Refresh the list after adding a new perfume
              }
            },
          ),
        ]
            : [],
      ),
<<<<<<< Updated upstream
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isAdmin)
=======
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            width: 100,
            height: 60,
            child: ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MySearchPage(isAdmin: widget.isAdmin),
                ),
              );
            }, child: Text("Search Page", style: TextStyle(color: Colors.black),),
            ),
          ),
          SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
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
>>>>>>> Stashed changes
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
<<<<<<< Updated upstream
                            builder: (context) => EditPerfumeScreen(perfume: perfumes[index]),
=======
                            builder: (context) => EditPerfumeScreen(
                              perfume: perfumes[index],
                            ),
>>>>>>> Stashed changes
                          ),
                        );

                        if (result == true) {
                          _queryAll(); // Refresh the list after updating a perfume
                        }
                      },
                    ),
<<<<<<< Updated upstream
                  if (widget.isAdmin)
=======
>>>>>>> Stashed changes
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deletePerfume(perfumes[index].id);
                      },
                    ),
<<<<<<< Updated upstream
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PerfumeDetailScreen(perfume: perfumes[index]),
                  ),
                );
              },
            ),
          );
        },
=======
                  ],
                )
                    : null,
              );
            },
          ),
        ],
>>>>>>> Stashed changes
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
