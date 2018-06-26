import 'dart:async';

import 'package:android_istar_app/models/lesson/lesson.dart';
import 'package:android_istar_app/screens/lesson/lessonThemeUtil.dart';
import 'package:android_istar_app/screens/lesson/lessonUtil.dart';
import 'package:android_istar_app/utils/customcolors.dart';
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

class LessonPlayState extends State<LessonPlay> {
  final _controller = new PageController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<http.Response> _responseFuture;
  Lesson lesson;
  Timer timer;
  int currentSlideTime = 10;
  int currentIndex = 0;

  bool _isAutoPlay = false;
  bool _firstTime = true;

  bool showBootomBar = true;

  @override
  void initState() {
    super.initState();
    _responseFuture = http
        .get('http://business.talentify.in/lessonXMLs/10260/10260/10260.xml');

    SystemChannels.lifecycle.setMessageHandler((msg) {
      debugPrint('SystemChannels> $msg');
      if (msg.toString() == AppLifecycleState.paused.toString()) {
        debugPrint('on pause Called');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showBottomSheet() {
    try {
      if (_scaffoldKey.currentState != null) {
        _scaffoldKey.currentState.showBottomSheet((context) {
          if (showBootomBar) {
            return new Container(
                width: screenWidth,
                height: screenHeight * 0.13,
                decoration: new ShapeDecoration(
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0))),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                        child: new IconButton(
                      icon: new Icon(
                        Icons.navigate_before,
                        size: 40.0,
                        color: CustomColors.theme_color,
                      ),
                      onPressed: () {
                        if (currentIndex > 0) {
                          _controller.jumpToPage(currentIndex - 1);
                        }
                      },
                    )),
                    new Expanded(
                        child: new IconButton(
                      icon: new Icon(
                        _isAutoPlay
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline,
                        size: 40.0,
                        color: CustomColors.theme_color,
                      ),
                      onPressed: () {
                        if (_isAutoPlay) {
                          timer.cancel();
                          setState(() {
                            _isAutoPlay = false;
                          });
                          showBottomSheet();
                        } else {
                          setState(() {
                            _isAutoPlay = true;
                          });
                          createCountdownTimer();
                          showBottomSheet();
                        }
                      },
                    )),
                    new Expanded(
                        child: new IconButton(
                      icon: new Icon(
                        Icons.navigate_next,
                        size: 40.0,
                        color: CustomColors.theme_color,
                      ),
                      onPressed: () {
                        if (currentIndex < lesson.slideLists.length - 1) {
                          _controller.jumpToPage(currentIndex + 1);
                        }
                      },
                    ))
                  ],
                ));
          } else {
            return new Container(height: 0.0, color: Colors.transparent);
          }
        });
      } else {
        debugPrint("bottom nav on null state");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setEnabledSystemUIOverlays([]);

    List<Widget> _pages = new List();

    return new Scaffold(
        key: _scaffoldKey,
        body: new Stack(
          children: <Widget>[
            new FutureBuilder<http.Response>(
                future: _responseFuture, // a Future<String> or null
                builder: (BuildContext context,
                    AsyncSnapshot<http.Response> snapshot) {
                  if (!snapshot.hasData) {
                    return new Center(
                        child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new SizedBox(
                            width: screenWidth,
                            height: screenHeight,
                            child: new Image(
                              image:
                                  new AssetImage("assets/images/loading.gif"),
                              gaplessPlayback: true,
                              fit: BoxFit.fill,
                            )),
                        //new Text("Fetching...")
                      ],
                    ));
                  } else {
                    XmlDocument document = xml.parse(snapshot.data.body);
                    Iterable<XmlElement> lessons =
                        document.findElements('lesson');
                    LessonUtil lessonUtil = new LessonUtil(lessons);
                    lesson = lessonUtil.createLessonObject();
                    LessonThemeUtil lessonThemeUtil = new LessonThemeUtil(
                        screenWidth, screenHeight, context, this);
                    try {
                      lesson.slideLists.forEach((slide) {
                        _pages.add(lessonThemeUtil.getPages(slide));
                      });
                    } catch (e) {}

                    if (_firstTime) {
                      createFirstTime();
                    }

                    /* physics:, */
                    return new PageView.builder(
                      physics: _isAutoPlay
                          ? new NeverScrollableScrollPhysics()
                          : AlwaysScrollableScrollPhysics(),
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
    print("pos----$index");
    currentIndex = index;
  }

  void createCountdownTimer() {
    if (_firstTime) {
      setState(() {
        _firstTime = false;
      });

      if (timer != null && timer.isActive) {
        timer.cancel();
      }
      _isAutoPlay = true;
      timer =
          new Timer(new Duration(seconds: currentSlideTime), onTimerCompletes);
    } else if (_isAutoPlay) {
      if (timer != null && timer.isActive) {
        timer.cancel();
      }
      setState(() {
        _isAutoPlay = true;
      });

      timer =
          new Timer(new Duration(seconds: currentSlideTime), onTimerCompletes);
    }
  }

  void onTimerCompletes() {
    print(_isAutoPlay);
    if (currentIndex < lesson.slideLists.length) {
      _controller.jumpToPage(currentIndex + 1);
      createCountdownTimer();
    } else {
      print("end of lesson");
    }
  }

  void createFirstTime() async {
    new Timer(new Duration(seconds: 2), createCountdownTimer);
  }
}
