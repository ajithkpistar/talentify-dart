import 'package:android_istar_app/models/lesson/slide.dart';
import 'package:android_istar_app/utils/customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LessonThemeUtil {
  static const String LESSON_INTRODUCTION_CARD = "LESSON_INTRODUCTION_CARD";
  double screenHeight, screenWidth;
  LessonThemeUtil(this.screenWidth, this.screenHeight);

  Widget getPages(Slide slide) {
    Widget widget;
    switch (slide.template) {
      case LESSON_INTRODUCTION_CARD:
        widget = getLessonIntroductionCard(slide);
        break;
      case "":
        break;
      default:
        widget = getDefaultSlide(slide);
        break;
    }
    return widget;
  }

  Widget getLessonIntroductionCard(Slide slide) {
    return new Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
          image: new Image.network(slide.image_bg).image,
          fit: BoxFit.cover,
        )),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
                flex: 4,
                child: new Container(
                    /* margin: const EdgeInsets.only(top: 20.0), */
                    child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SizedBox(
                        height: 60.0,
                        width: 60.0,
                        child: new Image.asset("assets/talentify_white.png")),
                    new Text("Sigma",
                        style: new TextStyle(
                            fontSize: 24.0,
                            fontFamily: "LatoBold",
                            color: Colors.white)),
                    new Text("Phoneonix",
                        style: new TextStyle(
                            fontSize: 18.0,
                            fontFamily: "LatoRegular",
                            color: Colors.white))
                  ],
                ))),
            new Expanded(
                flex: 2,
                child: new Container(
                    child: new Column(children: <Widget>[
                  new Divider(height: 2.0, color: Colors.white),
                  new Expanded(
                      child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Expanded(
                          flex: 49,
                          child: new Container(
                              color: Colors.transparent,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text("65",
                                      style: new TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "LatoBold",
                                          color: Colors.white)),
                                  new Text("High Score",
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: "LatoRegular",
                                          color: Colors.white))
                                ],
                              ))),
                      new Expanded(
                          child:
                              new Container(width: 2.0, color: Colors.white70)),
                      new Expanded(
                          flex: 49,
                          child: new Container(
                              color: Colors.transparent,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text("75/2000",
                                      style: new TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "LatoBold",
                                          color: Colors.white)),
                                  new Text("Difficulty",
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: "LatoRegular",
                                          color: Colors.white))
                                ],
                              )))
                    ],
                  )),
                  new Divider(height: 2.0, color: Colors.white)
                ]))),
            new Expanded(
                flex: 3,
                child: new SingleChildScrollView(
                    child: new RichText(
                        text: new TextSpan(
                            text: slide.p,
                            style: new TextStyle(fontSize: 14.0))))),
            new Expanded(
                flex: 1,
                child: new Center(
                    child: new Container(
                        width: screenWidth * 0.8,
                        child: new RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            onPressed: () => print("on taped"),
                            elevation: 3.0,
                            color: Colors.white,
                            textColor: Colors.white,
                            child: new Text(
                              "Next",
                              style: new TextStyle(
                                  color: CustomColors.theme_color,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            )))))
          ],
        ));
  }

  Widget getDefaultSlide(Slide slide) {
    return new Center(
      child: new Text(slide.template),
    );
  }
}
