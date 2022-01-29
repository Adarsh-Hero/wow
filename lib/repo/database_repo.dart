import 'package:sqflite/sqflite.dart';

class Repository {
  static String dbName = "atlanta.db";
  Database db;

  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();

  Future open() async {
    db = await openDatabase(dbName, version: 1, onCreate: (db, version) async {
      var batch = db.batch();
      // We create all the tables
      _createTableUsers(batch);
      await batch.commit();
    });
  }

  Future close() async {
    await db.close();
  }

  void _createTableUsers(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS users');
    batch.execute('''CREATE TABLE users (
  email TEXT,
  id TEXT,
  name TEXT,
  address TEXT,
  phone TEXT, 
  website TEXT,
  company TEXT,
  userName TEXT
)''');
  }
}
