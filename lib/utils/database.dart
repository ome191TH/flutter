import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<dynamic> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'customer.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE customers (id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
    );
    return database;
  }


  Future<dynamic> get db async {
    //print('get db');
    if(_db == null) {
      _db = await initDatabase();
    }
    return _db ;
  }
}
