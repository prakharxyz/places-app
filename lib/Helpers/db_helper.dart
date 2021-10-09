import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  //this static method creates database once if it doesn't already exist. it returns a database 
  static Future<Database> database() async { 
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'), //open/create database places at dbpath location
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1); //execute instruc to create table with specified columns
  }

  //this static method doesnt returns anything, it helps insert a map of [values] into the specified [table]
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace, 
      //if id or primary key is same then replace previous record. thus insert or update always occurs
    );
  }

 //this static method retrieves List of map from specified table
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
