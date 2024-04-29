import 'package:flutter/material.dart';
import 'perfume.dart';
import 'dbhelper.dart';

class MyAppUPDATE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePageUPDATE(),
    );
  }
}

class MyHomePageUPDATE extends StatefulWidget {
  @override
  _MyHomePageUPDATEState createState() => _MyHomePageUPDATEState();
}

class _MyHomePageUPDATEState extends State<MyHomePageUPDATE> {
  final dbHelper = DBHelper.instance;

  List<Perfume> perfumes = [];
  TextEditingController idController = TextEditingController();
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
        title: Text('Update perfume'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: brandController,
              initialValue: brandController.text,
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
                    child: Text('UPDATE'),
                    onPressed: () {
                      int id = int.parse(idController.text);
                      String brand = brandController.text;
                      String name = nameController.text;
                      String perfumeNumber = perfumeNumberController.text;
                      double price = double.parse(priceController.text);
                      String? imageUrl = imageUrlController.text;
                      int quantity = int.parse(quantityController.text);
                      _update(id, brand, name, perfumeNumber, price, imageUrl,
                          quantity);
                      _queryAll();
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
                          color: Colors.grey,
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
