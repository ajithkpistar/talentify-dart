import 'package:android_istar_app/screens/dashboard/dashboardPage.dart';
import 'package:android_istar_app/screens/lesson/lessonPlay.dart';
import 'package:android_istar_app/screens/roles/rolePage.dart';
import 'package:flutter/material.dart';
import 'package:android_istar_app/screens/login/loginPage.dart';
import 'package:android_istar_app/screens/home/homePage.dart';
import 'package:android_istar_app/screens/splash/splashPage.dart';

final routes = {
  '/home': (BuildContext context) => new HomeScreen(),
  '/login': (BuildContext context) => new LoginPage(),
  '/splash': (BuildContext context) => new SplashScreen(),
  '/dashBoard': (BuildContext context) => new DashBoard(),
  '/roles': (BuildContext context) => new RolePage(),
  '/lessonplay': (BuildContext context) => new LessonPlay(),
};
