import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? database;

  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  Future<Database> checkDB() async {
    if (database != null) {
      return database!;
    } else {
      return await createDB();
    }
  }

  Future<Database> createDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "my.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE student(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,mobile TEXT)";

        db.execute(query);
      },
    );
  }

  void insertData({
    required name,
    required mobile,
  }) async {
    database = await checkDB();
    database!.insert("student", {
      "name": name,
      "mobile": mobile,
    });
  }

  Future<List<Map>> ReadData() async {
    database = await checkDB();

    String query = "SELECT * FROM student";
    List<Map> list = await database!.rawQuery(query);
    print("${list}");
    return list;
  }

  Future<void> deleteData({required id}) async {
    database = await checkDB();
    database!.delete("student", where: "id=?", whereArgs: [id]);
  }

  void updateData({
    required id,
    required name,
    required mobile,
  }) {
    database!.update(
      "student",
      {
        "name": name,
        "mobile": mobile,
      },
      whereArgs: [id],
      where: "id=?",
    );
  }
}
