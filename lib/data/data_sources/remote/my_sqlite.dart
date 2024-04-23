import 'package:blog_app/data/models/todo_model.dart';
import 'package:blog_app/data/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final databaseName = "anuj.db";
  String noteTable =
      "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, content TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP, isDone INTEGER)";

  String users = "CREATE TABLE users(email TEXT, password TEXT UNIQUE)";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    print('yoooooooooooooooooooooo');
    print(databasePath);
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1);
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

  // Create a new tasks
  Future<int> createTasks(TodoModel todo) async {
    final Database db = await initDB();
    print('Fetched todos: $todo');
    return db.insert('notes', todo.toMap());
  }

  // Delete the tasks with the help of indexing
  Future<int> deleteTasks(int id) async {
    final Database db = await initDB();
    print("Deleted tasks $db");
    return db.delete('notes', where: "id = ?", whereArgs: [id]);
  }

  // Update the tasks list
  Future<int> updateTasks(String title, String content, int id) async {
    final Database db = await initDB();
    print("Updated tasks $db");
    return db.update('notes', {'title': title, 'content': content},
        where: "id = ?", whereArgs: [id]);
  }

  // Search the notes and task
  Future<List<TodoModel>> searchTasks(String keyword) async {
    final Database db = await initDB();
    List<Map<String, dynamic>> searchResults = await db.query(
      'notes',
      where: "title LIKE ?",
      whereArgs: ['%$keyword%'],
    );
    print("searchResults: $searchResults");
    List<TodoModel> tasks = searchResults.map((task) => TodoModel.fromMap(task)).toList();
    return tasks;
  }

  // Fetching the tasks from database
  Future<List<TodoModel>> getTasks() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    print('Fetched todos: $result');
    return result.map((e) => TodoModel.fromMap(e)).toList();
  }
}
