import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:android_istar_app/utils/customcolors.dart';

class SplashScreen extends StatefulWidget {
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            backgroundColor: CustomColors.theme_color,
            body: new Container(
              child: new Center(
                child: new Center(
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      new SizedBox(
                          height: 60.0,
                          width: 60.0,
                          child: new Image.asset("assets/talentify_white.png")),
                      new Container(
                          margin: const EdgeInsets.all(5.0),
                          child: new Text(
                            "Talentify",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 20.0),
                          ))
                    ])),
              ),
            )));
  }
}
