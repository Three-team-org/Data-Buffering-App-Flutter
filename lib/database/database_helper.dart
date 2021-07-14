import 'dart:async';
import 'dart:io' as io;

import 'package:data_buffer/database/model/form.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE calendar_info(id INTEGER PRIMARY KEY, grocery_name TEXT, water_type TEXT,vit_type TEXT,"
            "color TEXT,reaction TEXT,hygiene TEXT,date TEXT)");
  }

  Future<int> saveUser(Form_draft user) async {
    var dbClient = await db;
    int res = await dbClient.insert("calendar_info", user.toMap());
    return res;
  }

  Future<List<Map>> getDraft(String date) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM calendar_info where date like "$date"');
    List<Form_draft> employees = new List();
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      var user =
      new Form_draft(list[i]["grocery_name"], list[i]["water_type"], list[i]["vit_type"], list[i]["color"],
          list[i]["reaction"], list[i]["hygiene"], list[i]["date"]);
      user.setUserId(list[i]["id"]);

      employees.add(user);
    }

    return list;
  }

  Future<int> deleteUsers(Form_draft user) async {
    var dbClient = await db;

    int res =
    await dbClient.rawDelete('DELETE FROM User WHERE id = ?', [user.id]);
    return res;
  }

  Future<bool> update(Form_draft user) async {
    var dbClient = await db;




    int res =   await dbClient.update("User", user.toMap(),
        where: "id = ?", whereArgs: <int>[user.id]);



    return res > 0 ? true : false;
  }
}
