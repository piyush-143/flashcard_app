import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();
  static const String tableName = "FlashCard_Table";
  static const String columnQuestion = "Question";
  static const String columnAnswer = "Answer";
  static const String columnSno = "S_No";
  Database? myDB;

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }
  }

  Future<Database> openDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbpath = join(dir.path, "flashCardDB.db");

    return await openDatabase(dbpath, onCreate: (db, version) async {
      db.execute(
        "create table $tableName ( $columnSno integer primary key autoincrement, $columnQuestion text, $columnAnswer text)",
      );
      await db.insert(tableName, {
        columnQuestion: "Flutter is developed by which organisation",
        columnAnswer: "Google"
      });
      await db.insert(tableName, {
        columnQuestion: "Async and Await keyword are used for what",
        columnAnswer: "Asynchronous Programming"
      });
      await db.insert(tableName, {
        columnQuestion: "Which function is executed before build method",
        columnAnswer: "initState(){}"
      });
    }, version: 1);
  }

  Future<bool> addFlashCard({required String ques, required String ans}) async {
    var db = await getDB();
    int rowsEffected = await db.insert(tableName, {
      columnQuestion: ques,
      columnAnswer: ans,
    });
    return rowsEffected > 0;
  }

  Future<bool> updateFlashCard(
      {required String ques, required String ans, required int sno}) async {
    var db = await getDB();
    int rowsEffected = await db.update(
        tableName,
        {
          columnQuestion: ques,
          columnAnswer: ans,
        },
        where: "$columnSno=$sno");
    return rowsEffected > 0;
  }

  Future<bool> deleteFlashCard({required int sno}) async {
    var db = await getDB();
    int rowsEffected =
        await db.delete(tableName, where: "$columnSno=?", whereArgs: ['$sno']);
    return rowsEffected > 0;
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    var db = await getDB();
    List<Map<String, dynamic>> data = await db.query(tableName);
    return data;
  }
}
