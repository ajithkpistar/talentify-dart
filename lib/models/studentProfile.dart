import 'dart:async';
import 'package:sqflite/sqflite.dart';

final String tableStudentProfile = "studentpofile";
final String columnId = "id";
final String columnemail = "email";
final String columnfirstName = "firstName";
final String columnuserType = "userType";
final String columnbatchRank = "batchRank";
final String columngender = "gender";
final String columnisVerified = "isVerified";
final String columncoins = "coins";
final String columnmobile = "mobile";
final String columnexperiencePoints = "experiencePoints";
final String columndateOfBirth = "dateOfBirth";
final String columnprofileImage = "profileImage";

class StudentProfile {
  int id;
  String email;
  String firstName;
  String userType;
  int batchRank;
  String gender;
  bool isVerified;
  int coins;
  int mobile;
  int experiencePoints;
  String dateOfBirth;
  String profileImage;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnId: id,
      columnemail: email,
      columnfirstName: firstName,
      columnuserType: userType,
      columnbatchRank: batchRank,
      columngender: gender,
      columnisVerified: isVerified,
      columncoins: coins,
      columnmobile: mobile,
      columnexperiencePoints: experiencePoints,
      columndateOfBirth: dateOfBirth,
      columnprofileImage: profileImage
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  StudentProfile.fromMap(Map map) {
    id = map[columnId];
    email = map[columnemail];
    firstName = map[columnfirstName];
    userType = map[columnuserType];
    batchRank = map[columnbatchRank];
    gender = map[columngender];
    isVerified = map[columnisVerified] == 1 ? true : false;
    coins = map[columncoins];
    mobile = map[columnmobile];
    experiencePoints = map[columnexperiencePoints];
    dateOfBirth = map[columndateOfBirth];
    profileImage = map[columnprofileImage];
  }

  StudentProfile();

  StudentProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        firstName = json['firstName'],
        userType = json['userType'],
        batchRank = json['batchRank'],
        gender = json['gender'],
        isVerified = json['isVerified'],
        coins = json['coins'],
        mobile = json['mobile'],
        experiencePoints = json['experiencePoints'],
        dateOfBirth = json['dateOfBirth'],
        profileImage = json['profileImage'];
}

class StudentProfileProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableStudentProfile ( 
  $columnId integer primary key autoincrement, 
  $columnemail text not null,
  $columnfirstName text,
  $columnuserType text,
  $columnbatchRank integer,
  $columngender text,
  $columnisVerified boolean,
  $columncoins integer,
  $columnmobile integer,
  $columnexperiencePoints integer,
  $columndateOfBirth text,
  $columnprofileImage text not null)''');
    });
  }

  Future<StudentProfile> insert(StudentProfile studentProfile) async {
    StudentProfile studentProfie = await getStudentProfile(studentProfile.id);
    if (studentProfie == null) {
      await db.insert(tableStudentProfile, studentProfile.toMap());
    }
    return studentProfile;
  }

  Future<int> getStudentProfileCount() async {
    List<Map> maps = await db.query(tableStudentProfile, columns: [columnId]);
    return maps.length;
  }

  Future<StudentProfile> getStudentProfile(int id) async {
    List<Map> maps = await db.query(tableStudentProfile,
        columns: [
          columnId,
          columnemail,
          columnfirstName,
          columnuserType,
          columnbatchRank,
          columngender,
          columnisVerified,
          columncoins,
          columnmobile,
          columnexperiencePoints,
          columndateOfBirth,
          columnprofileImage
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new StudentProfile.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableStudentProfile, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(StudentProfile studentProfile) async {
    return await db.update(tableStudentProfile, studentProfile.toMap(),
        where: "$columnId = ?", whereArgs: [studentProfile.id]);
  }

  Future close() async => db.close();
}
