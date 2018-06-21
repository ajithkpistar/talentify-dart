import 'dart:async';

import 'package:android_istar_app/models/tasksObject.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:android_istar_app/models/studentProfile.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = new DbHelper.internal();
  factory DbHelper() => _instance;
  static Database _db;
  String path;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DbHelper.internal();

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE studentpofile(id integer primary key,email text not null,firstName text,userType text,  batchRank integer,  gender text,  isVerified boolean,  coins integer,  mobile integer,  experiencePoints integer,  dateOfBirth text,  profileImage text)");
    await db.execute(
        "CREATE TABLE tasks(id integer primary key, duration integer, itemId integer,  status text not null, itemType text, description text, title text, date text, completedDate text, content_type text, messageForCompletedTasks text, messageForIncompleteTasks text, imageURL text, header text, lessonUrl text)");
  }

  getUserProvide() async {
    StudentProfileProvider profileProvider =
        new StudentProfileProvider(await db);
    return profileProvider;
  }

  getTasksProvide() async {
    TasksProvider taskProvider = new TasksProvider(await db);
    return taskProvider;
  }
}
