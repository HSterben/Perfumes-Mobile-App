import 'models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "Spectra.db";
  static final _databaseVersion = 1;

  static final userTable = 'User_table';
  static final perfumeTable = 'Perfume_table';
  static final cartTable = 'Cart_table';

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

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

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
    await db.execute('''
      CREATE TABLE $cartTable (
        perfumeID INTEGER PRIMARY KEY,
        perfumeBrand TEXT,
        perfumeName TEXT,
        perfumeNumber TEXT,
        perfumePrice TEXT,
        imageUrl TEXT,
        quantity TEXT
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
      CREATE TABLE $cartTable (
        $perfumeID INTEGER PRIMARY KEY,
        $perfumeBrand TEXT,
        $perfumeName TEXT,
        $perfumeNumber TEXT,
        $perfumePrice TEXT,
        $imageUrl TEXT,
        $quantity TEXT
      )
      ''');
    }
  }

  Future<int?> insertUser(User user) async {
    Database? db = await instance.database;
    return await db
        ?.insert(userTable, {'email': user.email, 'password': user.password});
  }

  Future<List<Map<String, dynamic>>?> queryAllUsers() async {
    Database? db = await instance.database;
    return await db?.query(userTable);
  }

  Future<List<Map<String, dynamic>>?> queryUser(email) async {
    Database? db = await instance.database;
    return await db
        ?.query(userTable, where: "$userEmail = ?", whereArgs: [email]);
  }

  Future<int?> queryUserCount() async {
    Database? db = await instance.database;
    final List<Map<String, Object?>>? result =
        await db?.rawQuery('SELECT COUNT(*) FROM $userTable');
    final List<Map<String, Object?>> nonNullableResult =
        result ?? []; // Handle null case
    return Sqflite.firstIntValue(nonNullableResult) ?? 0;
  }

  Future<int?> updateUser(User user) async {
    Database? db = await instance.database;
    int id = user.toMap()['id'];
    return await db?.update(userTable, user.toMap(),
        where: '$userID = ?', whereArgs: [id]);
  }

  Future<int?> deleteUser(int id) async {
    Database? db = await instance.database;
    return await db?.delete(userTable, where: '$userID = ?', whereArgs: [id]);
  }

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

  Future<List<Map<String, dynamic>>?> queryAllPerfumes() async {
    Database? db = await instance.database;
    return await db?.query(perfumeTable);
  }

  Future<List<Map<String, dynamic>>?> queryPerfume(query) async {
    Database? db = await instance.database;
    return await db?.query(perfumeTable,
        where:
            "$perfumeName LIKE '%$query%' OR $perfumeBrand LIKE '%$query%' OR $perfumeNumber LIKE '%$query%'");
  }

  Future<int?> queryPerfumeCount() async {
    Database? db = await instance.database;
    final List<Map<String, Object?>>? result =
        await db?.rawQuery('SELECT COUNT(*) FROM $perfumeTable');
    final List<Map<String, Object?>> nonNullableResult =
        result ?? []; // Handle null case
    return Sqflite.firstIntValue(nonNullableResult) ?? 0;
  }

  Future<int?> updatePerfume(Perfume perfume) async {
    Database? db = await instance.database;
    return await db?.update(
      perfumeTable,
      perfume.toMap(),
      where: '$perfumeID = ?',
      whereArgs: [perfume.id],
    );
  }

  Future<int?> deletePerfume(int id) async {
    Database? db = await instance.database;
    return await db
        ?.delete(perfumeTable, where: '$perfumeID = ?', whereArgs: [id]);
  }

  Future<int?> insertCartItem(Perfume perfume) async {
    Database? db = await instance.database;
    return await db?.insert(cartTable, perfume.toMap());
  }

  Future<List<Map<String, dynamic>>?> queryAllCartItems() async {
    Database? db = await instance.database;
    return await db?.query(cartTable);
  }
}
