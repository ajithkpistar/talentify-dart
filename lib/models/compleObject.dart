import 'dart:async';
import 'package:android_istar_app/models/studentProfile.dart';
import 'package:sqflite/sqflite.dart';

final String tableComplexObject = "comleobject";
final String columnId = "id";
final String columnStudentProfile = "studentProfile";
final String columnTasks = "tasks";
final String columnCourses = "courses";
final String columnAssessmentReports = "assessmentReports";
final String columnNotifications = "notifications";

class ComplexObject {
  int id;
  StudentProfile studentProfile;
  String tasks;
  String courses;
  String assessmentReports;
  String notifications;

  Map toMap() {
    Map map = {
      columnId: id,
      columnStudentProfile: studentProfile,
      columnTasks: tasks,
      columnCourses: courses,
      columnAssessmentReports: assessmentReports,
      columnNotifications: notifications
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  ComplexObject();

  ComplexObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        studentProfile = json['studentProfile'],
        tasks = json['tasks'],
        courses = json['courses'],
        assessmentReports = json['assessmentReports'],
        notifications = json['notifications'];

  ComplexObject.fromMap(Map map) {
    id = map[columnId];
    studentProfile = map[studentProfile];
    tasks = map[tasks];
    courses = map[courses];
    assessmentReports = map[assessmentReports];
    notifications = map[notifications];
  }
}

class ComplexObjectProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableComplexObject ( 
  $columnId integer primary key autoincrement, 
  $columnStudentProfile text not null,
  $columnTasks text not null,
  $columnCourses text not null,
  $columnAssessmentReports text not null,
  $columnNotifications text not null)''');
    });
  }

  Future<ComplexObject> insert(ComplexObject todo) async {
    todo.id = await db.insert(tableComplexObject, todo.toMap());
    return todo;
  }

  Future<ComplexObject> getComplexObject(int id) async {
    List<Map> maps = await db.query(tableComplexObject,
        columns: [
          columnId,
          columnStudentProfile,
          columnTasks,
          columnCourses,
          columnAssessmentReports,
          columnNotifications
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new ComplexObject.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableComplexObject, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(ComplexObject complexobject) async {
    return await db.update(tableComplexObject, complexobject.toMap(),
        where: "$columnId = ?", whereArgs: [complexobject.id]);
  }

  Future close() async => db.close();
}
