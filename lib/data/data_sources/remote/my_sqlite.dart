import 'package:blog_app/data/models/todo_model.dart';
import 'package:blog_app/data/models/user_model.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final databaseName = "notes.db";
  String noteTable =
      "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, content TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP, isDone INTEGER)";

  String users = "CREATE TABLE users(email TEXT, password TEXT UNIQUE)";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    print('yoooooooooooooooooooooo');
    print(databasePath);
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(noteTable);
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

  // Create a new tasks
  Future<int> createTasks(TodoModel todo) async {
    final Database db = await initDB();
    var result = db.insert('notes', todo.toDatabaseJson());
    return result;
  }

  // Delete the tasks with the help of indexing
  Future<int> deleteTasks(int id) async {
    final Database db = await initDB();
    var results = await db.delete('notes', where: "id = ?", whereArgs: [id]);
    return results;
  }

  // Update the tasks list
  Future<int> updateTasks(title, content, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update notes set title = ?, noteContent = ? where noteId = ?',
        [title, content, noteId]);
  }

  // Search the notes and task
  Future<List<TodoModel>> searchTasks(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResults = await db
        .rawQuery("select * from notes where title LIKE ?", ["%$keyword%"]);
    return searchResults.map((e) => TodoModel.fromDatabaseJson(e)).toList();
  }

  // Fetching the tasks from database 
  Future<List<TodoModel>> getTasks() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => TodoModel.fromDatabaseJson(e)).toList();
  }
}
