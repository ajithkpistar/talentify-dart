import 'package:android_istar_app/screens/lesson/lessonPlay.dart';
import 'package:android_istar_app/utils/databaseUtil.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

import 'package:android_istar_app/models/studentProfile.dart';
import 'package:android_istar_app/screens/home/homePage.dart';
import 'package:android_istar_app/screens/splash/splashPage.dart';

Widget _defaultHome = new HomeScreen();

void main() async {
  await _evaluateInitialRoute();
  runApp(new MyApp());
}

_evaluateInitialRoute() async {
  StudentProfileProvider profileProvider =
      await new DbHelper().getUserProvide();

  int len = await profileProvider.getStudentProfileCount();
  if (len == 0) {
    _defaultHome = new HomeScreen();
  } else {
    _defaultHome = new SplashScreen();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LessonPlay(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
