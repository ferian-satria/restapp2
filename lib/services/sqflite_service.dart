import 'package:path/path.dart';
import 'package:restapp2/model/list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;
  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // var path = '/my/db/path';

    if (identical(0, 0.0)) {
      // print('web');
      databaseFactory = databaseFactoryFfiWeb;
      // path = 'databaseFav.db';
      // _database = await openDatabase(path);
      _database = await _initDB('databaseFav.db');

      // print('web ini');
    } else {
      _database = await _initDB('databaseFav.db');
    }

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // const textType = 'TEXT NOT NULL';
    // const boolType = 'BOOLEAN NOT NULL';
    // const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE favRestaurant ( 
  id TEXT NOT NULL, 
  rating DOUBLE NOT NULL,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  city TEXT NOT NULL,
  pictureId TEXT NOT NULL
  )
''');
  }

  Future<void> create(RestaurantModel data) async {
    final db = await instance.database;
    final id = await db.insert('favRestaurant', data.toJson());
    // return data.copy(id: id.toString());
  }

  Future<RestaurantModel> readTodo({required String id}) async {
    final db = await instance.database;

    final maps = await db.query(
      'favRestaurant',
      // columns: TodoFields.values,
      where: 'id= ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RestaurantModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<RestaurantModel>> readAllTodos() async {
    final db = await instance.database;
    const orderBy = 'name ASC';
    final result = await db.query('favRestaurant', orderBy: orderBy);

    return result.map((json) => RestaurantModel.fromJson(json)).toList();
  }

  Future<int> update({required RestaurantModel data}) async {
    final db = await instance.database;

    return db.update(
      'favRestaurant',
      data.toJson(),
      where: 'id= ?',
      whereArgs: [data.id],
    );
  }

  Future<int> delete({required String id}) async {
    final db = await instance.database;

    return await db.delete(
      'favRestaurant',
      where: 'id= ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
