import 'package:flutter/material.dart';
import 'home.dart';
import 'models.dart';
import 'dbhelper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dbHelper = DatabaseHelper.instance;

  List<User> users = [];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainPage(),
    );
  }

  Widget mainPage() {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          child: Text(
            "Spectra Perfumes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50, right: 10, left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 5)
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 20, bottom: 10),
                    decoration: BoxDecoration(
                      border: showLogin
                          ? Border()
                          : Border(
                              bottom: BorderSide(
                                  color: Colors.deepPurpleAccent, width: 3),
                            ),
                    ),
                    child: GestureDetector(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          showLogin = false;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 20, bottom: 10),
                    decoration: BoxDecoration(
                      border: showLogin
                          ? Border(
                              bottom: BorderSide(
                                  color: Colors.deepPurpleAccent, width: 3),
                            )
                          : Border(),
                    ),
                    child: GestureDetector(
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          showLogin = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
              showLogin ? _buildLogin() : _buildCreateAccount(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildCreateAccount() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create Account',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 10),
            Text(
              "Let\'s get started by filling out the form below.",
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: 300,
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(40.0), // Set border radius here
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 60,
              child: TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(40.0), // Set border radius here
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 25, bottom: 253),
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  onPressed: () {
                    String email = emailController.text;
                    String pass = passwordController.text;
                    _insertUser(email, pass);
                    emailController.clear();
                    passwordController.clear();
                    showLogin = true;
                    _queryAllUsers();
                  },
                  child: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildLogin() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome Back',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 10),
            Text(
              "Fill out the information below in order to access your account.",
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: 300,
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(40.0), // Set border radius here
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 60,
              child: TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(40.0), // Set border radius here
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 25, bottom: 232),
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  onPressed: () {
                    String email = emailController.text;
                    String password = passwordController.text;
                    _loginUser(email, password);
                    emailController.clear();
                    passwordController.clear();
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _loginUser(email, password) {
    _queryAllUsers();
    for (User u in users) {
      if (u.email == email) {
        if (u.password == password) {
          // final snackBar = SnackBar(content: Text('Logging in'));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MyHomePage(),
            ),
          );
          return;
        }
      }
    }
    final snackBar = SnackBar(content: Text('Wrong email or password'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _insertUser(email, password) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.userEmail: email,
      DatabaseHelper.userPassword: password
    };
    User user = User.fromMap(row);
    final id = await dbHelper.insertUser(user);
    print("inserted user!");
  }

  void _queryAllUsers() async {
    final allRows = await dbHelper.queryAllUsers();
    users.clear();
    allRows?.forEach((row) => users.add(User.fromMap(row)));
    setState(() {});
  }

  void _updateUser(id, userEmail, userPassword) async {
    User user = User(id: id, email: userEmail, password: userPassword);
    final rowsAffected = await dbHelper.updateUser(user);
  }

  void _deleteUser(id) async {
    final rowsDeleted = await dbHelper.deleteUser(id);
  }
}

// void _login() async {
//   List<User> users = await dbHelper.queryAllUsers();
//   for (User user in users) {
//     if (user.email == emailController.text) {
//       if (user.password == passwordController.text) {
//         final snackBar = SnackBar(content: Text('Logging in'));
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => MyHomePage()));
//         return;
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Error'),
//             content: Text('Invalid password'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//         return;
//       }
//     }
//   }
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text('Error'),
//       content: Text('Invalid username or password'),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('OK'),
//         ),
//       ],
//     ),
//   );
// }
//
// void _insert(String email, String pass) async {
//   String username = email.substring(0, email.indexOf('@'));
//   User user = User(email: email, password: pass);
//   await dbHelper.insertUser(user);
//   final snackBar = SnackBar(content: Text('Account created'));
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
//}

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final dbHelper = DatabaseHelper.instance;
//
//   List<User> persons = [];
//   int updateID = -1;
//
//   TextEditingController fNameController = TextEditingController();
//   TextEditingController lNameController = TextEditingController();
//
//   TextEditingController idDeleteController = TextEditingController();
//
//   TextEditingController queryController = TextEditingController();
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text('Flutter Assignment 2 Part 1'),
//       ),
//       body: Container(
//         padding: EdgeInsets.only(left: 20, right: 20),
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               controller: fNameController,
//               decoration: InputDecoration(
//                 labelText: 'First Name',
//               ),
//             ),
//             TextFormField(
//               controller: lNameController,
//               decoration: InputDecoration(
//                 labelText: 'Last Name',
//               ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   width: 170,
//                   child: ElevatedButton(
//                     child: Text('ADD'),
//                     onPressed: () {
//                       String fName = fNameController.text;
//                       String lName = lNameController.text;
//                       _insert(fName, lName);
//                       _queryAll();
//                       fNameController.clear();
//                       lNameController.clear();
//                       updateID = -1;
//                     },
//                   ),
//                 ),
//                 Container(
//                   width: 170,
//                   child: ElevatedButton(
//                     child: Text('UPDATE'),
//                     onPressed: () {
//                       String fName = fNameController.text;
//                       String lName = lNameController.text;
//                       _update(updateID, fName, lName);
//                       _queryAll();
//                       fNameController.clear();
//                       lNameController.clear();
//                       updateID = -1;
//                     },
//                   ),
//                 )
//               ],
//             ),
//             Divider(
//               thickness: 2,
//               color: Colors.indigo,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: persons.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     height: 60,
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Colors.grey, // Choose the color you want for the line
//                         ),
//                       ),
//                     ),
//                     child: Row(children: [
//                       Text(
//                         '${persons[index].email} ${persons[index].password}',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       Spacer(),
//                       // GestureDetector(
//                       //   onTap: () {
//                       //     fNameController.text = persons[index].email!;
//                       //     lNameController.text = persons[index].password!;
//                       //     updateID = int.parse(persons[index].id!);
//                       //   },
//                       //   child: Container(
//                       //     width: 40,
//                       //     height: 40,
//                       //     decoration: BoxDecoration(
//                       //       image: DecorationImage(
//                       //         image: AssetImage('assets/edit.png'),
//                       //         fit: BoxFit.cover,
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                       // GestureDetector(
//                       //   onTap: () {
//                       //     _delete(persons[index].id);
//                       //     _queryAll();
//                       //   },
//                       //   child: Container(
//                       //     width: 40,
//                       //     height: 40,
//                       //     decoration: BoxDecoration(
//                       //       image: DecorationImage(
//                       //         image: AssetImage('assets/trash.png'),
//                       //         fit: BoxFit.cover,
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Row _createPersonButton() {
//     return Row();
//   }
//
//   void _insert(firstName, lastName) async {
//     // row to insert
//     Map<String, dynamic> row = {
//       DatabaseHelper.userEmail: firstName,
//       DatabaseHelper.userPassword: lastName
//     };
//     User person = User.fromMap(row);
//     final id = await dbHelper.insertUser(person);
//     // _showMessageInScaffold('inserted row id: $id');
//   }
//
//   void _queryAll() async {
//     final allRows = await dbHelper.queryAllUsers();
//     persons.clear();
//     allRows?.forEach((row) => persons.add(User.fromMap(row)));
//     setState(() {});
//   }
//
//   void _update(id, fName, lName) async {
//     User person = User(id: id, email: fName, password: lName);
//     final rowsAffected = await dbHelper.updateUser(person);
//   }
//
//   void _delete(id) async {
//     final rowsDeleted = await dbHelper.deleteUser(id);
//   }
// }
