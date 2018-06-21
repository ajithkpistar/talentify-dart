import 'dart:async';
import 'package:sqflite/sqflite.dart';

final String tableStudentProfile = "studentpofile";
/* column definations */
final String cId = "id";
final String cEmail = "email";
final String cFirstName = "firstName";
final String cUserType = "userType";
final String cBatchRank = "batchRank";
final String cGender = "gender";
final String cIsVerified = "isVerified";
final String cCoins = "coins";
final String cMobile = "mobile";
final String cExperiencePoints = "experiencePoints";
final String cDateOfBirth = "dateOfBirth";
final String cProfileImage = "profileImage";

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
      cId: id,
      cEmail: email,
      cFirstName: firstName,
      cUserType: userType,
      cBatchRank: batchRank,
      cGender: gender,
      cIsVerified: isVerified,
      cCoins: coins,
      cMobile: mobile,
      cExperiencePoints: experiencePoints,
      cDateOfBirth: dateOfBirth,
      cProfileImage: profileImage
    };
    if (id != null) {
      map[cId] = id;
    }
    return map;
  }

  StudentProfile.fromMap(Map map) {
    id = map[cId];
    email = map[cEmail];
    firstName = map[cFirstName];
    userType = map[cUserType];
    batchRank = map[cBatchRank];
    gender = map[cGender];
    isVerified = map[cIsVerified] == 1 ? true : false;
    coins = map[cCoins];
    mobile = map[cMobile];
    experiencePoints = map[cExperiencePoints];
    dateOfBirth = map[cDateOfBirth];
    profileImage = map[cProfileImage];
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

  StudentProfileProvider(_db) {
    db = _db;
  }

  Future<StudentProfile> insert(StudentProfile studentProfile) async {
    StudentProfile profile = await getStudentProfile(studentProfile.id);
    if (profile == null) {
      await db.insert(tableStudentProfile, studentProfile.toMap());
    } else {
      update(studentProfile);
    }
    return studentProfile;
  }

  Future<int> getStudentProfileCount() async {
    List<Map> maps = await db.query(tableStudentProfile, columns: [cId]);
    return maps.length;
  }

  Future<StudentProfile> getStudentProfile(int id) async {
    List<Map> maps = await db.query(tableStudentProfile,
        columns: [
          cId,
          cEmail,
          cFirstName,
          cUserType,
          cBatchRank,
          cGender,
          cIsVerified,
          cCoins,
          cMobile,
          cExperiencePoints,
          cDateOfBirth,
          cProfileImage
        ],
        where: "$cId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new StudentProfile.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableStudentProfile, where: "$cId = ?", whereArgs: [id]);
  }

  Future<int> update(StudentProfile studentProfile) async {
    return await db.update(tableStudentProfile, studentProfile.toMap(),
        where: "$cId = ?", whereArgs: [studentProfile.id]);
  }

  Future close() async => db.close();
}
