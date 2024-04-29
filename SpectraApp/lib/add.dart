import 'package:flutter/material.dart';
import 'perfume.dart';
import 'dbhelper.dart';

class MyAppADD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePageADD(),
    );
  }
}

class MyHomePageADD extends StatefulWidget {
  @override
  _MyHomePageADDState createState() => _MyHomePageADDState();
}

class _MyHomePageADDState extends State<MyHomePageADD> {
  final dbHelper = DBHelper.instance;

  List<Perfume> perfumes = [];

  TextEditingController brandController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController perfumeNumberController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add perfume'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: brandController,
              decoration: InputDecoration(
                labelText: 'Brand',
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: perfumeNumberController,
              decoration: InputDecoration(
                labelText: 'Perfume Number',
              ),
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            TextFormField(
              controller: imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image URL',
              ),
            ),
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity in Stock',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 170,
                  child: ElevatedButton(
                    child: Text('ADD'),
                    onPressed: () {
                      String brand = brandController.text;
                      String name = nameController.text;
                      String perfumeNumber = perfumeNumberController.text;
                      double price = double.parse(priceController.text);
                      String? imageUrl = imageUrlController.text;
                      int quantity = int.parse(quantityController.text);
                      _insert(brand, name, perfumeNumber, price, imageUrl,
                          quantity);
                      _queryAll();
                      brandController.clear();
                      nameController.clear();
                      perfumeNumberController.clear();
                      priceController.clear();
                      imageUrlController.clear();
                      quantityController.clear();
                    },
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.indigo,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: perfumes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors
                              .grey, // Choose the color you want for the line
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${perfumes[index].brand} ${perfumes[index].name}',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        Text(
                          '${perfumes[index].quantity} ${perfumes[index].price}\$',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),
            Text(
              "HELLO HELLO",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void _insert(brand, name, perfumeNumber, price, imageUrl, quantity) async {
    // row to insert
    Map<String, dynamic> row = {
      DBHelper.columnBrand: brand,
      DBHelper.columnName: name,
      DBHelper.columnPerfumeNumber: perfumeNumber,
      DBHelper.columnPrice: price,
      DBHelper.columnImageUrl: imageUrl,
      DBHelper.columnQuantity: quantity
    };
    Perfume perfume = Perfume.fromMap(row);
    final id = await dbHelper.insert(perfume);
    // print('inserted row id: $id');
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    perfumes.clear();
    allRows?.forEach((row) => perfumes.add(Perfume.fromMap(row)));
    setState(() {});
  }

  void _update(
      id, brand, name, perfumeNumber, price, imageUrl, quantity) async {
    Perfume perfume = Perfume(
        id: id,
        brand: brand,
        name: name,
        perfumeNumber: perfumeNumber,
        price: price,
        imageUrl: imageUrl,
        quantity: quantity);
    final rowsAffected = await dbHelper.update(perfume);
  }

  void _delete(id) async {
    final rowsDeleted = await dbHelper.delete(id);
  }
}
