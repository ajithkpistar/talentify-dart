import 'dart:async';

import 'package:android_istar_app/models/tasksObject.dart';
import 'package:android_istar_app/utils/bottomBarUtil.dart';
import 'package:android_istar_app/utils/databaseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:android_istar_app/utils/customcolors.dart';

double screenHeight, screenWidth;
BottomBarUtil bottomBarUtil;

class RolePage extends StatefulWidget {
  RolePageState createState() => new RolePageState();
}

class RolePageState extends State<RolePage> {
  @override
  void initState() {
    super.initState();
    bottomBarUtil = new BottomBarUtil();
  }

  Future<List<Tasks>> get _responseFuture async {
    TasksProvider profileProvider = await new DbHelper().getTasksProvide();
    List<Tasks> tasksdata = await profileProvider.getAllTasks();
    print(tasksdata.length);
    return tasksdata;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    BottomNavigationBar botNavBar = BottomBarUtil.newBottomBar(1, context);

    return new MaterialApp(
        home: new Scaffold(
      body: new Theme(
          data: new ThemeData(
              primaryColor: CustomColors.theme_color,
              accentColor: Colors.orange,
              hintColor: CustomColors.pure_grey),
          child: new FutureBuilder(
            future: _responseFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Tasks>> response) {
              if (!response.hasData) {
                return const Center(
                  child: const Text('Loading...'),
                );
              } else
                return const Center(
                  child: const Text('Loading...'),
                );
              /* else {
              return new MyExpansionTileList(response.data);
            } */
            },
          )),
      bottomNavigationBar: botNavBar,
    ));
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: CustomColors.theme_color,
    );
  }
}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
        margin: const EdgeInsets.all(4.0),
        width: iconTheme.size - 8.0,
        height: iconTheme.size - 8.0,
        decoration: new BoxDecoration(
          border: new Border.all(color: iconTheme.color, width: 2.0),
        ));
  }
}

class MyExpansionTileList extends StatelessWidget {
  final List<Tasks> elementList;
  MyExpansionTileList(this.elementList);

  List<Widget> _getChildren() {
    List<Widget> children = [];
    elementList.forEach((element) {
      // print("id: " + element['id']);

      Container button = new Container(
          width: screenWidth - screenWidth * 0.3,
          height: 40.0,
          child: new RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () => print("$element.id"),
              elevation: 3.0,
              color: CustomColors.theme_color,
              textColor: Colors.white,
              child: new Text(
                element.itemType,
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              )));

      double cardHeight = (screenHeight * 70) / 100;
      children.add(new Container(
          height: cardHeight - cardHeight * 0.1,
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Stack(children: <Widget>[
                new Container(
                  height: cardHeight,
                ),
                Positioned(
                    left: 0.0,
                    right: 0.0,
                    child: new Container(
                      height: cardHeight * 0.9,
                      width: screenWidth - (screenWidth * 0.09),
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: new Card(
                          elevation: 15.0,
                          color: Colors.white,
                          child: new Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new ListTile(
                                title: new Text(element.header),
                                subtitle: new Text(element.title),
                              ),
                              new Image.network(element.imageURL,
                                  fit: BoxFit.cover),
                            ],
                          )),
                    )),
                Positioned(
                    top: cardHeight - cardHeight * 0.171,
                    left: 0.0,
                    right: 0.0,
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[button])),
              ])
            ],
          )));
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
//
    BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.art_track,
              color: CustomColors.theme_color,
            ),
            title: new Text("tasks",
                style: new TextStyle(color: CustomColors.theme_color)),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.art_track,
              color: CustomColors.theme_color,
            ),
            title: new Text("tasks",
                style: new TextStyle(color: CustomColors.theme_color)),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.art_track,
              color: CustomColors.theme_color,
            ),
            title: new Text("tasks",
                style: new TextStyle(color: CustomColors.theme_color)),
          ),
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
        backgroundColor: CustomColors.pale_grey,
        /* appBar: new AppBar(
            leading: new GestureDetector(
          child: _DiamondFab(
            child: const Icon(Icons.add),
          ),
        )), */
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new SizedBox(
                  height: screenHeight - screenHeight * 0.3,
                  child: new PageView(children: _getChildren()))
            ],
          ),
        ),
        bottomNavigationBar: new Theme(
            data: Theme.of(context).copyWith(
                canvasColor: CustomColors.theme_color,
                primaryColor: Colors.green,
                textTheme: Theme
                    .of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.yellow))),
            child: bottomNavigationBar));
  }

  void navigationTapped(int page) {
    print('page----' + page.toString());
    if (page == 1) {
      /* Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new SecondScreen()),
      ); */
    }
  }
}
