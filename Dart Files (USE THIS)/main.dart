import 'package:flutter/material.dart';
import 'package:spectraapp/dbhelper.dart';
import 'order.dart';
import 'add.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spectra Perfume',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void _login() {
    if (emailController.text == 'admin' && passwordController.text == 'admin') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid username or password'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  // Boolean value to toggle between login and create account
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
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppADD()));
        }, child: Text("Testing this")),
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
                    _update(updateID, fName, lName);
                    _queryAll();
                    fNameController.clear();
                    lNameController.clear();
                    updateID = -1;
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
                    _login();
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
  void _insert(email, pass) async {
    // row to insert
    Map<String, dynamic> row = {
      DBHelper.columnFName: firstName,
      DBHelper.columnLName: lastName
    };
    Person person = Person.fromMap(row);
    final id = await dbHelper.insert(person);
    // _showMessageInScaffold('inserted row id: $id');
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    persons.clear();
    allRows?.forEach((row) => persons.add(Person.fromMap(row)));
    setState(() {});
  }

  void _update(id, fName, lName) async {
    Person person = Person(id: id, firstName: fName, lastName: lName);
    final rowsAffected = await dbHelper.update(person);
  }

  void _delete(id) async {
    final rowsDeleted = await dbHelper.delete(id);
  }
}
