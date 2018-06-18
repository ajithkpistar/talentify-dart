import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:android_istar_app/utils/customcolors.dart';
import 'main.dart';

void main() {
  runApp(new MyApp());
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<http.Response> _responseFuture;

  @override
  void initState() {
    super.initState();
    _responseFuture =
        http.get('http://business.talentify.in:9090/istar/rest/user/3/complex');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new FutureBuilder(
        future: _responseFuture,
        builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
          if (!response.hasData) {
            return const Center(
              child: const Text('Loading...'),
            );
          } else if (response.data.statusCode != 200) {
            return const Center(
              child: const Text('Error loading data'),
            );
          } else {
            print(response.data.body);
            List<dynamic> json = JSON.decode(response.data.body)['tasks'];
            return new MyExpansionTileList(json);
          }
        },
      ),
    );
  }
}

class MyExpansionTileList extends StatelessWidget {
  final List<dynamic> elementList;
  BottomNavigationBar bottomNavigationBar1;
  BuildContext context;

  MyExpansionTileList(this.elementList);

  List<Widget> _getChildren() {
    List<Widget> children = [];
    elementList.forEach((element) {
      // print("id: " + element['id']);

      RaisedButton button = new RaisedButton(
        color: Colors.red[800],
        textColor: Colors.white,
        child: const Text('Presenation'),
        onPressed: () {},
      );

      children.add(new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new ListTile(
              title: new Text(element['header']),
              subtitle: new Text(element['title']),
            ),
            new Image.network(element['imageURL'], fit: BoxFit.cover),
            new Container(
                margin: const EdgeInsets.only(bottom: 100.0), child: button)
          ],
        ),
      ));
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
//
    bottomNavigationBar1 = new BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: 1,
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(
                Icons.art_track,
                color: CustomColors.theme_color,
              ),
              title: new Text("tasks",
                  style: new TextStyle(color: CustomColors.theme_color)),
              backgroundColor: Colors.white),
          new BottomNavigationBarItem(
              icon: new Icon(
                Icons.art_track,
                color: CustomColors.theme_color,
              ),
              title: new Text("Roles",
                  style: new TextStyle(color: CustomColors.theme_color)),
              backgroundColor: Colors.white),
          new BottomNavigationBarItem(
              icon: new Icon(
                Icons.art_track,
                color: CustomColors.theme_color,
              ),
              title: new Text("tasks",
                  style: new TextStyle(color: CustomColors.theme_color)),
              backgroundColor: Colors.white),
          new BottomNavigationBarItem(
              icon: new Icon(
                Icons.art_track,
                color: CustomColors.theme_color,
              ),
              title: new Text("tasks",
                  style: new TextStyle(color: CustomColors.theme_color)),
              backgroundColor: Colors.white),
          new BottomNavigationBarItem(
              icon: new Icon(
                Icons.art_track,
                color: CustomColors.theme_color,
              ),
              title: new Text("tasks",
                  style: new TextStyle(color: CustomColors.theme_color)),
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped);

    return new Scaffold(
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new SizedBox(
                  height: 540.0, child: new PageView(children: _getChildren()))
            ],
          ),
        ),
        bottomNavigationBar: new Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                primaryColor: Colors.green,
                textTheme: Theme
                    .of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.yellow))),
            child: bottomNavigationBar1));
  }

  void navigationTapped(int page) {
    print('page----' + page.toString());
    if (page == 0) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new MyApp()),
      );
    }
  }
}
