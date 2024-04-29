// dbhelper.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'perfume.dart';

class DBHelper {
  static final _databaseName = "perfumeDatabase.db";
  static final _databaseVersion = 1;
  static final table = 'perfume_table';

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnBrand = 'brand';
  static final columnPrice = 'price';
  static final columnImageUrl = 'imageUrl';
  static final columnQuantity = 'quantity';

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
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
        $columnTitle TEXT NOT NULL,
        $columnBrand TEXT NOT NULL,
        $columnPrice REAL NOT NULL,
        $columnImageUrl TEXT NOT NULL,
        $columnQuantity INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insert(Perfume perfume) async {
    Database db = await database;
    return await db.insert(table, perfume.toMap());
  }

  Future<List<Perfume>> queryAll() async {
    Database db = await database;
    var res = await db.query(table);
    List<Perfume> list = res.isNotEmpty ? res.map((c) => Perfume.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> update(Perfume perfume) async {
    Database db = await database;
    return await db.update(table, perfume.toMap(),
        where: '$columnId = ?', whereArgs: [perfume.id]);
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
