import 'dart:async';
import 'package:sqflite/sqflite.dart';

final String tableComplexObject = "comleobject";
final String columnId = "id";
final String columnStudentProfile = "studentProfile";
final String columnTasks = "tasks";
final String columnCourses = "courses";
final String columnAssessmentReports = "assessmentReports";
final String columnNotifications = "notifications";

class Tasks {
  int id;
  String status;
  String itemType;
  String description;
  String title;
  String date;
  String completedDate;
  int duration;
  int itemId;
  String content_type;
  String messageForCompletedTasks;
  String messageForIncompleteTasks;
  String imageURL;
  String header;
  String lessonUrl;

  Tasks();

  Tasks.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        itemType = json['itemType'],
        description = json['description'],
        title = json['title'],
        date = json['date'],
        completedDate = json['completedDate'],
        duration = json['duration'],
        itemId = json['itemId'],
        content_type = json['content_type'],
        messageForCompletedTasks = json['messageForCompletedTasks'],
        imageURL = json['imageURL'],
        header = json['header'],
        lessonUrl = json['lessonUrl'];
}
