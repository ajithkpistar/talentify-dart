import 'dart:async';

import 'package:android_istar_app/models/lesson/lesson.dart';
import 'package:android_istar_app/screens/lesson/lessonThemeUtil.dart';
import 'package:android_istar_app/screens/lesson/lessonUtil.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml/nodes/document.dart';
import 'package:xml/xml/nodes/element.dart';

double screenHeight, screenWidth;

class LessonPlay extends StatefulWidget {
  LessonPlayState createState() => new LessonPlayState();
}

/// An indicator showing the currently selected page of a PageController
class LessonPlayState extends State<LessonPlay> {
  final _controller = new PageController();
  Future<http.Response> _responseFuture;

  Lesson lesson;

  @override
  void initState() {
    super.initState();
    _responseFuture = http
        .get('http://business.talentify.in/lessonXMLs/10260/10260/10260.xml');
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setEnabledSystemUIOverlays([]);

    List<Widget> _pages = new List();

    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        new FutureBuilder<http.Response>(
            future: _responseFuture, // a Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              } else {
                XmlDocument document = xml.parse(snapshot.data.body);
                Iterable<XmlElement> lessons = document.findElements('lesson');
                LessonUtil lessonUtil = new LessonUtil(lessons);
                lesson = lessonUtil.createLessonObject();
                LessonThemeUtil lessonThemeUtil =
                    new LessonThemeUtil(screenWidth, screenHeight);
                try {
                  lesson.slideLists.forEach((slide) {
                    _pages.add(lessonThemeUtil.getPages(slide));
                  });
                } catch (e) {}

                /* physics:new NeverScrollableScrollPhysics(), */
                return new PageView.builder(
                  physics: new AlwaysScrollableScrollPhysics(),
                  controller: _controller,
                  itemCount: lesson.slideLists.length,
                  onPageChanged: pageOnchangeListener,
                  itemBuilder: (BuildContext context, int index) {
                    return _pages[index];
                  },
                );
              }
            })
      ],
    ));
  }

  pageOnchangeListener(index) {
    print("len----$index");
  }
}
