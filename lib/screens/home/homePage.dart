import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:android_istar_app/utils/customcolors.dart';

class HomeScreen extends StatefulWidget {
  DemoState1 createState() => new DemoState1();
}

class DemoState1 extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            body: new Container(
      child: new Center(
        child: new RaisedButton(
          child: new Text(
            'Begin',
            style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            _handleLogin(context);
          },
        ),
      ),
    )));
  }

  void _handleLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/login');
  }
}
