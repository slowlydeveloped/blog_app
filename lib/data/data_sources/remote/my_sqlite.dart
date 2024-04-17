import 'package:blog_app/data/models/user_model.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> savedCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
  prefs.setString('password', password);
  }

  Future<Map<String, dynamic>?> getSavedCredentials() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> result = await db.query('users');
    if (result.isNotEmpty) {
      return result.elementAt(1);
    }
    return null;
  }
}
