import 'dart:async';
import 'dart:io' as io;

import 'package:data_buffer/database/model/form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:data_buffer/database/model/user_data.dart';
import 'package:data_buffer/database/model/hospital_data.dart';

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
        "color TEXT,reaction TEXT,hygiene TEXT,date TEXT, spoon_select TEXT, upper_selected TEXT, lower_selected TEXT, user_role TEXT, user_name TEXT, user_id INTEGER)");
    await db.execute(
        "CREATE TABLE user_info(id INTEGER PRIMARY KEY, full_name TEXT,doctor_name TEXT,dentist_name TEXT, birthday TEXT,gender TEXT,"
        "weight TEXT,length TEXT,time TEXT, avatar_path TEXT, user_role TEXT)");
    await db.execute(
        "CREATE TABLE hospital_info(id INTEGER PRIMARY KEY, doctor_name TEXT, dentist_name TEXT,weight TEXT,"
        "length TEXT,advice TEXT,remarks TEXT,  date_save TEXT"
        ", user_role TEXT, user_name TEXT, user_id INTEGER)");
  }

  Future<int> saveUser(Form_draft user) async {
    var dbClient = await db;
    int res = await dbClient.insert("calendar_info", user.toMap());
    return res;
  }

  Future<int> saveUserData(User_data user) async {
    var dbClient = await db;
    int res = await dbClient.insert("user_info", user.toMap());
    return res;
  }

  Future<int> saveHospitalData(Hospital_data user) async {
    var dbClient = await db;
    print(user.toMap());
    int res = await dbClient.insert("hospital_info", user.toMap());
    return res;
  }

  // Future<List<Map>> getDraft(
  //     String date, String user_role, String user_name) async {
  //   var dbClient = await db;
  //   List<Map> list = await dbClient.rawQuery(
  //       'SELECT * FROM calendar_info where date like "$date" AND user_role like "$user_role" AND user_name like "$user_name"');
  //   List<Form_draft> employees = new List();
  //   print(list.length);
  //   for (int i = 0; i < list.length; i++) {
  //     var user = new Form_draft(
  //       list[i]["grocery_name"],
  //       list[i]["water_type"],
  //       list[i]["vit_type"],
  //       list[i]["color"],
  //       list[i]["reaction"],
  //       list[i]["hygiene"],
  //       list[i]["date"],
  //       list[i]["spoon_select"],
  //       list[i]["upper_selected"],
  //       list[i]["lower_selected"],
  //       list[i]["user_role"],
  //       list[i]["user_name"],
  //       list[i]["user_id"],
  //     );
  //     user.setUserId(list[i]["id"]);

  //     employees.add(user);
  //   }

  //   return list;
  // }

  Future<List<Map>> getDraft(String date, int userId) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM calendar_info where date like "$date" AND user_id = "$userId"');
    List<Form_draft> employees = new List();
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      var user = new Form_draft(
        list[i]["grocery_name"],
        list[i]["water_type"],
        list[i]["vit_type"],
        list[i]["color"],
        list[i]["reaction"],
        list[i]["hygiene"],
        list[i]["date"],
        list[i]["spoon_select"],
        list[i]["upper_selected"],
        list[i]["lower_selected"],
        list[i]["user_role"],
        list[i]["user_name"],
        list[i]["user_id"],
      );
      user.setUserId(list[i]["id"]);

      employees.add(user);
    }

    return list;
  }

  Future<List<Map>> getDraft_admin(String date, String user_role) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM calendar_info where date like "$date" AND user_role like "$user_role"');
    List<Form_draft> employees = new List();
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      var user = new Form_draft(
        list[i]["grocery_name"],
        list[i]["water_type"],
        list[i]["vit_type"],
        list[i]["color"],
        list[i]["reaction"],
        list[i]["hygiene"],
        list[i]["date"],
        list[i]["spoon_select"],
        list[i]["upper_selected"],
        list[i]["lower_selected"],
        list[i]["user_role"],
        list[i]["user_name"],
        list[i]["user_id"],
      );
      user.setUserId(list[i]["id"]);

      employees.add(user);
    }

    return list;
  }

  Future<List<Map>> getUserInfo(String user_role) async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery('SELECT * FROM user_info where user_role like "$user_role"');
    List<User_data> employees = new List();
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      var user = new User_data(
          list[i]["full_name"],
          list[i]["doctor_name"],
          list[i]["dentist_name"],
          list[i]["birthday"],
          list[i]["gender"],
          list[i]["weight"],
          list[i]["length"],
          list[i]["time"],
          list[i]["avatar_path"],
          list[i]["user_role"]);
      user.setUserId(list[i]["id"]);

      employees.add(user);
    }

    return list;
  }

  Future<List<Map>> getUserInfo_all() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM user_info');
    List<User_data> employees = new List();
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      var user = new User_data(
          list[i]["full_name"],
          list[i]["doctor_name"],
          list[i]["dentist_name"],
          list[i]["birthday"],
          list[i]["gender"],
          list[i]["weight"],
          list[i]["length"],
          list[i]["time"],
          list[i]["avatar_path"],
          list[i]["user_role"]);
      user.setUserId(list[i]["id"]);

      employees.add(user);
    }

    return list;
  }

  // Future<List<Map>> getHospitalData(
  //     String date, String user_role, String user_name) async {
  //   var dbClient = await db;
  //   List<Map> list = await dbClient.rawQuery(
  //       'SELECT * FROM hospital_info where date_save like "$date" AND user_role like "$user_role" AND user_name like "$user_name"');
  //   List<Hospital_data> employees = new List();
  //   print(list.length);
  //   for (int i = 0; i < list.length; i++) {
  //     var user = new Hospital_data(
  //         list[i]["doctor_name"],
  //         list[i]["dentist_name"],
  //         list[i]["weight"],
  //         list[i]["length"],
  //         list[i]["advice"],
  //         list[i]["remarks"],
  //         list[i]["date_save"],
  //         list[i]["user_role"],
  //         list[i]["user_name"]);
  //     user.setUserId(list[i]["id"]);

  //     employees.add(user);
  //   }
  //   return list;
  // }

  Future<List<Map>> getHospitalData(String date, int userId) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM hospital_info where date_save like "$date" AND user_id = "$userId"');
    List<Hospital_data> employees = new List();
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      var user = new Hospital_data(
        list[i]["doctor_name"],
        list[i]["dentist_name"],
        list[i]["weight"],
        list[i]["length"],
        list[i]["advice"],
        list[i]["remarks"],
        list[i]["date_save"],
        list[i]["user_role"],
        list[i]["user_name"],
        list[i]["user_id"],
      );
      user.setUserId(list[i]["id"]);

      employees.add(user);
    }

    return list;
  }

  Future<List<Map>> getHospitalData_admin(String date, String user_role) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM hospital_info where date_save like "$date" AND user_role like "$user_role"');
    List<Hospital_data> employees = new List();
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      var user = new Hospital_data(
        list[i]["doctor_name"],
        list[i]["dentist_name"],
        list[i]["weight"],
        list[i]["length"],
        list[i]["advice"],
        list[i]["remarks"],
        list[i]["date_save"],
        list[i]["user_role"],
        list[i]["user_name"],
        list[i]["user_id"],
      );
      user.setUserId(list[i]["id"]);

      employees.add(user);
    }

    return list;
  }

  Future<int> deleteUsers(int user_id) async {
    var dbClient = await db;

    int res = await dbClient
        .rawDelete('DELETE FROM user_info WHERE id = ?', [user_id]);
    return res;
  }

  Future<bool> update(Form_draft user) async {
    var dbClient = await db;

    int res = await dbClient.update("User", user.toMap(),
        where: "id = ?", whereArgs: <int>[user.id]);

    return res > 0 ? true : false;
  }
}
