import 'package:android_istar_app/utils/customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  DemoState1 createState() => new DemoState1();
}

class DemoState1 extends State<HomeScreen> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return new MaterialApp(
        home: new Scaffold(
            body: new Container(
                width: screenWidth,
                height: screenHeight,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    new Container(
                        height: ((screenHeight * 70) / 100),
                        color: Colors.white,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Divider(height: 30.0, color: Colors.white),
                            new SizedBox(
                              width: 80.0,
                              height: 80.0,
                              child: new Image.asset(
                                  "assets/talentify_logo_red.png"),
                            ),
                            new Divider(height: 20.0, color: Colors.white),
                            new Text("TALENTIFY",
                                style: new TextStyle(
                                    color: CustomColors.grey_color,
                                    fontSize: 22.0,
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                    new Container(
                      height: ((screenHeight * 30) / 100),
                      color: Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                              width: screenWidth - 30,
                              height: 45.0,
                              child: new RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  onPressed: () => _handleLogin(false),
                                  elevation: 5.0,
                                  color: CustomColors.theme_color,
                                  textColor: Colors.white,
                                  child: new Text(
                                    'GET STARTED',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          new Divider(height: 10.0, color: Colors.transparent),
                          new GestureDetector(
                              onTap: () => _handleLogin(true),
                              child: new Text("Already a member?",
                                  style: new TextStyle(
                                      color: CustomColors.grey_color,
                                      fontSize: 16.0,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.normal))),
                          new Divider(height: 10.0, color: Colors.transparent),
                        ],
                      ),
                    ),
                  ],
                ))));
  }

  void _handleLogin(bool isLogin) {
    if (isLogin) {
      Navigator.of(context).pushNamed('/login');
    } else {}
  }
}
