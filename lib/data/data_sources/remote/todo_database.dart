// // import 'dart:io';
// import 'package:blog_app/data/models/todo_model.dart';
// import 'package:path/path.dart';
// // import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseProvider {
//   final databaseName = 'todoTable.db';
//   String tasks =
//       "CREATE TABLE todoTable(id INTEGER PRIMARY KEY, description TEXT, isDone INTEGER)";

//   Future<Database> initDB() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, databaseName);
//     return openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute(tasks);
//       },
//     );
//   }

//   Future<int> createTasks(TODO todo) async {
//     final Database db = await initDB();
//     var result = db.insert(databaseName, todo.toDatabaseJson());
//     return result;
//   }

//   Future<List<TODO>> getTasks({List<String>? columns, String? query}) async {
//     final Database db = await initDB();
//     List<Map<String, dynamic>> result = [];
//     if (query != null) {
//       if (query.isNotEmpty) {
//         result = await db.query(databaseName,
//             columns: columns,
//             where: 'description LIKE ?',
//             whereArgs: ["%$query%"]);
//       }
//     } else {
//       result = await db.query(databaseName, columns: columns);
//     }
//     List<TODO> todos = result.isNotEmpty
//         ? result.map((item) => TODO.fromDatabaseJson(item)).toList()
//         : [];
//     return todos;
//   }

//   Future<int> updateTasks(TODO todo) async {
//     final Database db = await initDB();
//     var results = await db.update(databaseName, todo.toDatabaseJson(),
//         where: "id = ?", whereArgs: [todo.id]);
//     return results;
//   }

//   Future<int> deleteTasks(int id) async {
//     final Database db = await initDB();
//     var results =
//         await db.delete(databaseName, where: "id = ?", whereArgs: [id]);
//     return results;
//   }

//   Future deleteAllTodos() async {
//     final db = await initDB();
//     var result = await db.delete(
//       databaseName,
//     );

//     return result;
//   }
// }
