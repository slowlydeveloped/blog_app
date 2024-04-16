import 'package:blog_app/data/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final databaseName = "users.db";

  String users = "CREATE TABLE users( email TEXT, password TEXT UNIQUE)";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    print('yoooooooooooooooooooooo');
    print(databasePath);
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
    });
  }

  Future<bool> login(Users users) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from users where email = '${users.email}' AND password = '${users.password}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> signup(Users users) async {
    final Database db = await initDB();
print('Raw query result: ${await db.rawQuery("select * from users")}');
    return db.insert('users', users.toMap());
  }
}
