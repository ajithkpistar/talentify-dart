import 'package:android_istar_app/models/lesson/slide.dart';
import 'package:android_istar_app/utils/customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LessonThemeUtil {
  static const String LESSON_INTRODUCTION_CARD = "LESSON_INTRODUCTION_CARD";

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
                flex: 3,
                child: new Container(
                    color: Colors.green, child: new Text(slide.template))),
            new Expanded(
                flex: 3, child: new Container(child: new Text(slide.template))),
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
                      )),
                ))
          ],
        ));
  }

  Widget getDefaultSlide(Slide slide) {
    return new Center(
      child: new Text(slide.template),
    );
  }
}
