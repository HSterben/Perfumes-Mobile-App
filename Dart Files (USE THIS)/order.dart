// import 'package:flutter/material.dart';
// import 'add_edit_perfume.dart';
// import 'view_perfume.dart';
// import 'dbhelper.dart';
// import 'perfume.dart';
// import 'add_edit_perfume.dart';
//
// class OrderPage extends StatefulWidget {
//   @override
//   _OrderPageState createState() => _OrderPageState();
// }
//
// class _OrderPageState extends State<OrderPage> {
//   final DBHelper dbHelper = DBHelper.instance;
//   List<Perfume> perfumes = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _refreshPerfumeList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Perfumes'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               _navigateToAddEditPerfumePage();
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: perfumes.length,
//         itemBuilder: (context, index) {
//           final perfume = perfumes[index];
//           return ListTile(
//             title: Text(perfume.title),
//             subtitle: Text(perfume.brand),
//             trailing: Text('\$${perfume.price.toStringAsFixed(2)}'),
//             onTap: () {
//               // Here you can navigate to view perfume details
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   void _refreshPerfumeList() async {
//     List<Perfume> x = await dbHelper.queryAll();
//     setState(() {
//       perfumes = x;
//     });
//   }
//
//   void _navigateToAddEditPerfumePage() async {
//     // Push the AddEditPerfumePage and await the result
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AddEditPerfumePage()),
//     );
//
//     // If the result is 'true', refresh the perfume list
//     if (result == true) {
//       _refreshPerfumeList();
//     }
//   }
//
// }