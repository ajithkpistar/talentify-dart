import 'dart:async';

import 'package:android_istar_app/screens/lesson/lessonUtil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml/nodes/document.dart';
import 'package:xml/xml/nodes/element.dart';
import 'package:xml/xml/nodes/node.dart';

class LessonPlay extends StatefulWidget {
  LessonPlayState createState() => new LessonPlayState();
}

/// An indicator showing the currently selected page of a PageController
class LessonPlayState extends State<LessonPlay> {
  final _controller = new PageController();

  final _kArrowColor = Colors.black.withOpacity(0.8);
  Future<http.Response> _responseFuture;
  /* new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(colors: Colors.blue),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child:
          new FlutterLogo(style: FlutterLogoStyle.stacked, colors: Colors.red),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(
          style: FlutterLogoStyle.horizontal, colors: Colors.green),
    ), */

  @override
  void initState() {
    super.initState();
    _responseFuture = http
        .get('http://business.talentify.in/lessonXMLs/10271/10271/10271.xml');
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      new Text(
        "called",
        style: new TextStyle(fontFamily: 'LatoRegular'),
      ),
      new Text("sss")
    ];

    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        new FutureBuilder<http.Response>(
            future: _responseFuture, // a Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
              if (!snapshot.hasData) {
                return new Text("");
              } else {
                //print("data---" + snapshot.data.body);
                XmlDocument document = xml.parse(snapshot.data.body);
                Iterable<XmlElement> lessons = document.findElements('lesson');
                LessonUtil lessonUtil = new LessonUtil(lessons);
                lessonUtil.createLessonObject();

                //lessons.map((node) => node).forEach(printData);

                return new PageView.builder(
                  physics: new AlwaysScrollableScrollPhysics(),
                  controller: _controller,
                  itemCount: _pages.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("len----$index");
                    return _pages[index];
                  },
                );
              }
            })
      ],
    ));
  }
}
