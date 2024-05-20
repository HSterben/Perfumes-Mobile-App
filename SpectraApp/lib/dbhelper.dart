import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'perfumeModel.dart';
import 'userModel.dart';

class DBHelper {
  static final _databaseName = "PerfumeDatabase.db";
  static final _databaseVersion = 1;

  static final perfumeTable = 'Perfume_table';
  static final userTable = 'User_table';

  //Perfume columns
  static final columnId = 'id';
  static final columnBrand = 'brand';
  static final columnName = 'name';
  static final columnPerfumeNumber = 'perfume_number';
  static final columnPrice = 'price';
  static final columnImageUrl = 'imageUrl';
  static final columnQuantity = 'quantity';

  //User columns
  static final userId = 'id';
  static final username = 'username';
  static final userPassword = 'password';
  static final userEmail = 'email';

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // Create the Perfume table
    await db.execute('''
      CREATE TABLE $perfumeTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnBrand TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnPerfumeNumber TEXT NOT NULL,
        $columnPrice DOUBLE NOT NULL,
        $columnImageUrl TEXT NOT NULL,
        $columnQuantity INTEGER NOT NULL
      )
    ''');
    // Create the User table
    await db.execute('''
      CREATE TABLE $userTable (
        $userId INTEGER PRIMARY KEY AUTOINCREMENT,
        $username TEXT NOT NULL UNIQUE,
        $userPassword TEXT NOT NULL,
        $userEmail TEXT NOT NULL UNIQUE
      )
    ''');
  }

  // Insert a new user
  Future<int?> insertUser(User user) async {
    Database? db = await instance.database;
    return await db?.insert(userTable, user.toMap());
  }

  // Query all users
  Future<List<Map<String, dynamic>>?> queryAllUsers() async {
    Database? db = await instance.database;
    return await db?.query(userTable);
  }

  // Update a user
  Future<int?> updateUser(User user) async {
    Database? db = await instance.database;
    int id = user.toMap()['id'];
    return await db?.update(userTable, user.toMap(),
        where: '$userId = ?', whereArgs: [id]);
  }

  // Delete a user
  Future<int?> deleteUser(int id) async {
    Database? db = await instance.database;
    return await db?.delete(userTable, where: '$userId = ?', whereArgs: [id]);
  }

  Future<int?> insert(Perfume perfume) async {
    Database? db = await instance.database;
    return await db?.insert(perfumeTable, {
      'id': perfume.id,
      'brand': perfume.brand,
      'name': perfume.name,
      'perfume_number' : perfume.perfumeNumber,
      'price': perfume.price,
      'imageUrl': perfume.imageUrl,
      'quantity': perfume.quantity,
    });
  }

  Future<List<Map<String, dynamic>>?> queryAllRows() async {
    Database? db = await instance.database;
    return await db?.query(perfumeTable);
  }

  Future<List<Map<String, dynamic>>?> queryRows(name) async {
    Database? db = await instance.database;
    return await db?.query(perfumeTable, where: "$columnBrand LIKE '%$name%'");
  }

  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    final List<Map<String, Object?>>? result = await db?.rawQuery('SELECT COUNT(*) FROM $perfumeTable');
    final List<Map<String, Object?>> nonNullableResult = result ?? []; // Handle null case
    return Sqflite.firstIntValue(nonNullableResult) ?? 0;
  }

  Future<int?> update(Perfume perfume) async {
    Database? db = await instance.database;
    int id = perfume.toMap()['id'];
    return await db?.update(perfumeTable, perfume.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int?> delete(int id) async {
    Database? db = await instance.database;
    return await db?.delete(perfumeTable, where: '$columnId = ?', whereArgs: [id]);
  }
}
