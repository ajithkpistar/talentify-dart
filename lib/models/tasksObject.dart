import 'dart:async';
import 'package:sqflite/sqflite.dart';

final String tableTasks = "tasks";
final String cId = "id";
final String cStatus = "status";
final String cItemType = "itemType";
final String cDescription = "description";
final String cTitle = "title";
final String cDate = "date";
final String cCompletedDate = "completedDate";
final String cDuration = "duration";
final String cItemId = "itemId";
final String cContentType = "content_type";
final String cMessageForCompletedTasks = "messageForCompletedTasks";
final String cMessageForIncompleteTasks = "messageForIncompleteTasks";
final String cImageURL = "imageURL";
final String cHeader = "header";
final String cLessonUrl = "lessonUrl";

class Tasks {
  int id;
  int duration;
  int itemId;

  String status;
  String itemType;
  String description;
  String title;
  String date;
  String completedDate;
  String contentType;
  String messageForCompletedTasks;
  String messageForIncompleteTasks;
  String imageURL;
  String header;
  String lessonUrl;

  Tasks();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      cId: id,
      cStatus: status,
      cItemType: itemType,
      cDescription: description,
      cTitle: title,
      cDate: date,
      cCompletedDate: completedDate,
      cDuration: duration,
      cItemId: itemId,
      cContentType: contentType,
      cMessageForCompletedTasks: messageForCompletedTasks,
      cMessageForIncompleteTasks: messageForIncompleteTasks,
      cImageURL: imageURL,
      cHeader: header,
      cLessonUrl: lessonUrl
    };
    if (id != null) {
      map[cId] = id;
    }
    return map;
  }

  Tasks.fromMap(Map map) {
    id = map[cId];
    status = map[cStatus];
    itemType = map[cItemType];
    description = map[cDescription];
    title = map[cTitle];
    date = map[cDate];
    completedDate = map[cCompletedDate];
    duration = map[cDuration];
    itemId = map[itemId];
    contentType = map[cContentType];
    messageForCompletedTasks = map[cMessageForCompletedTasks];
    messageForIncompleteTasks = map[cMessageForIncompleteTasks];
    imageURL = map[cImageURL];
    header = map[cHeader];
    lessonUrl = map[cLessonUrl];
  }

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
        contentType = json['content_type'],
        messageForCompletedTasks = json['messageForCompletedTasks'],
        imageURL = json['imageURL'],
        header = json['header'],
        lessonUrl = json['lessonUrl'];
}

class TasksProvider {
  Database db;

  TasksProvider(_db) {
    db = _db;
  }

  Future<Tasks> insert(Tasks tasks) async {
    Tasks task = await getSpecificTask(tasks.id);
    if (task == null) {
      await db.insert(tableTasks, tasks.toMap());
    } else {
      update(tasks);
    }
    return tasks;
  }

  Future<int> getTasksCount() async {
    List<Map> maps = await db.query(tableTasks);
    return maps.length;
  }

  Future<List<Tasks>> getAllTasks() async {
    List<Map> maps = await db.query(tableTasks);

    List<Tasks> tasks = new List<Tasks>();
    for (dynamic item in maps) {
      tasks.add(Tasks.fromMap(item));
    }
    return tasks;
  }

  Future<Tasks> getSpecificTask(int id) async {
    List<Map> maps = await db.query(tableTasks,
        columns: [
          cId,
          cStatus,
          cItemType,
          cDescription,
          cTitle,
          cDate,
          cCompletedDate,
          cDuration,
          cItemId,
          cContentType,
          cMessageForCompletedTasks,
          cMessageForIncompleteTasks,
          cImageURL,
          cHeader,
          cLessonUrl
        ],
        where: "$cId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new Tasks.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTasks, where: "$cId = ?", whereArgs: [id]);
  }

  Future<int> update(Tasks tasks) async {
    return await db.update(tableTasks, tasks.toMap(),
        where: "$cId = ?", whereArgs: [tasks.id]);
  }

  Future close() async => db.close();
}
