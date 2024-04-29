import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'perfume.dart';

class DBHelper {
  static final _databaseName = "PerfumeDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'Perfume_table';

  static final columnId = 'id';
  static final columnBrand = 'brand';
  static final columnName = 'name';
  static final columnPerfumeNumber = 'perfume_number';
  static final columnPrice = 'price';
  static final columnImageUrl = 'imageUrl';
  static final columnQuantity = 'quantity';

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
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnBrand TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnPerfumeNumber TEXT NOT NULL,
        $columnPrice DOUBLE NOT NULL,
        $columnImageUrl TEXT NOT NULL,
        $columnQuantity INTEGER NOT NULL
      )
    ''');
  }

  Future<int?> insert(Perfume perfume) async {
    Database? db = await instance.database;
    return await db?.insert(table, {
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
    return await db?.query(table);
  }

  Future<List<Map<String, dynamic>>?> queryRows(name) async {
    Database? db = await instance.database;
    return await db?.query(table, where: "$columnBrand LIKE '%$name%'");
  }

  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    final List<Map<String, Object?>>? result = await db?.rawQuery('SELECT COUNT(*) FROM $table');
    final List<Map<String, Object?>> nonNullableResult = result ?? []; // Handle null case
    return Sqflite.firstIntValue(nonNullableResult) ?? 0;
  }

  Future<int?> update(Perfume perfume) async {
    Database? db = await instance.database;
    int id = perfume.toMap()['id'];
    return await db?.update(table, perfume.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int?> delete(int id) async {
    Database? db = await instance.database;
    return await db?.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
