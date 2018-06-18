import 'package:flutter/material.dart';

void main() {
  runApp(new HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(context, Icons.call, 'CALL'),
          buildButtonColumn(context, Icons.near_me, 'ROUTE'),
          buildButtonColumn(context, Icons.share, 'SHARE'),
        ],
      ),
    );

    return new MaterialApp(
        title: '',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Scaffold(
            body: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
              new Container(
                  color: Colors.white,
                  margin: new EdgeInsets.only(top: 50.0),
                  child: new Align(
                    alignment: Alignment.center,
                    child: new SizedBox(
                        height: 120.0,
                        width: 120.0,
                        child: new Image.network(
                          'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
                        )),
                  )),
              new Container(
                  color: Colors.white,
                  margin: new EdgeInsets.only(top: 150.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildButtonColumn(context, Icons.call, 'CALL'),
                      buildButtonColumn(context, Icons.near_me, 'ROUTE')
                    ],
                  )),
            ])));
  }

  Column buildButtonColumn(BuildContext context, icon, String label) {
    Color color = Theme.of(context).primaryColor;

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Icon(icon, color: color),
        new SizedBox(
            height: 120.0,
            width: 120.0,
            child: new Image.asset(
              'assets/talentify_logo_red.png',
            )),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
