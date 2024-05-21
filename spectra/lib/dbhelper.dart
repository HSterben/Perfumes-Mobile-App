import 'models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "Spectra.db";
  static final _databaseVersion = 1;

  static final userTable = 'User_table';
  static final perfumeTable = 'Perfume_table';

  //User Columns
  static final userID = 'id';
  static final userEmail = 'email';
  static final userPassword = 'password';

  //Perfume Columns
  static final perfumeID = 'id';
  static final perfumeBrand = 'brand';
  static final perfumeName = 'name';
  static final perfumeNumber = 'number';
  static final perfumePrice = 'price';
  static final imageUrl = 'image';
  static final quantity = 'quantity';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
 CREATE TABLE $userTable (
 $userID INTEGER PRIMARY KEY AUTOINCREMENT,
 $userEmail TEXT NOT NULL,
 $userPassword TEXT NOT NULL
 )
 ''');
    await db.execute('''
 CREATE TABLE $perfumeTable (
 $perfumeID INTEGER PRIMARY KEY AUTOINCREMENT,
 $perfumeBrand TEXT NOT NULL,
 $perfumeName TEXT NOT NULL,
 $perfumeNumber TEXT NOT NULL,
 $perfumePrice TEXT NOT NULL,
 $imageUrl TEXT NOT NULL,
 $quantity TEXT NOT NULL
 )
 ''');
  }

  //Users CRUD

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int?> insertUser(User user) async {
    Database? db = await instance.database;
    return await db
        ?.insert(userTable, {'email': user.email, 'password': user.password});
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>?> queryAllUsers() async {
    Database? db = await instance.database;
    return await db?.query(userTable);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>?> queryUser(email) async {
    Database? db = await instance.database;
    return await db
        ?.query(userTable, where: "$userEmail = ?", whereArgs: [email]);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryUserCount() async {
    Database? db = await instance.database;
    final List<Map<String, Object?>>? result =
        await db?.rawQuery('SELECT COUNT(*) FROM $userTable');
    final List<Map<String, Object?>> nonNullableResult =
        result ?? []; // Handle null case
    return Sqflite.firstIntValue(nonNullableResult) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int?> updateUser(User user) async {
    Database? db = await instance.database;
    int id = user.toMap()['id'];
    return await db?.update(userTable, user.toMap(),
        where: '$userID = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int?> deleteUser(int id) async {
    Database? db = await instance.database;
    return await db?.delete(userTable, where: '$userID = ?', whereArgs: [id]);
  }

  // Perfumes CRUD

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int?> insertPerfume(Perfume perfume) async {
    Database? db = await instance.database;
    return await db?.insert(perfumeTable, {
      'brand': perfume.brand,
      'name': perfume.name,
      'number': perfume.number,
      'price': perfume.price,
      'image': perfume.imageUrl,
      'quantity': perfume.quantity
    });
  }


  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>?> queryAllPerfumes() async {
    Database? db = await instance.database;
    return await db?.query(perfumeTable);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>?> queryPerfume(query) async {
    Database? db = await instance.database;
    return await db?.query(perfumeTable,
        where:
            "$perfumeName LIKE '%$query%' OR $perfumeBrand LIKE '%$query%' OR $perfumeNumber LIKE '%$query%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryPerfumeCount() async {
    Database? db = await instance.database;
    final List<Map<String, Object?>>? result =
        await db?.rawQuery('SELECT COUNT(*) FROM $perfumeTable');
    final List<Map<String, Object?>> nonNullableResult =
        result ?? []; // Handle null case
    return Sqflite.firstIntValue(nonNullableResult) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int?> updatePerfume(Perfume perfume) async {
    Database? db = await instance.database;
    return await db?.update(
      perfumeTable,
      perfume.toMap(),
      where: '$perfumeID = ?',
      whereArgs: [perfume.id],
    );
  }


  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int?> deletePerfume(int id) async {
    Database? db = await instance.database;
    return await db
        ?.delete(perfumeTable, where: '$perfumeID = ?', whereArgs: [id]);
  }
}
