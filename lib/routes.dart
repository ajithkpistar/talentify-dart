import 'package:flutter/material.dart';
import 'package:android_istar_app/screens/login/loginPage.dart';
import 'package:android_istar_app/screens/home/homePage.dart';
import 'package:android_istar_app/screens/splash/splashPage.dart';

final routes = {
  '/': (BuildContext context) => new HomeScreen(),
  '/home': (BuildContext context) => new LoginPage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/splash': (BuildContext context) => new SplashScreen()
};
