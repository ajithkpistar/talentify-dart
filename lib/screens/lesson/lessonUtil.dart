import 'package:android_istar_app/models/lesson/lesson.dart';
import 'package:android_istar_app/models/lesson/slide.dart';
import 'package:android_istar_app/models/lesson/slideInteractive.dart';
import 'package:android_istar_app/models/lesson/slideLI.dart';
import 'package:android_istar_app/models/lesson/slideUL.dart';
import 'package:xml/xml/nodes/element.dart';

class LessonUtil {
  Iterable<XmlElement> lessonsXML;
  Iterable<XmlElement> slideXML;
  LessonUtil(this.lessonsXML);

  createLessonObject() {
    Lesson lesson = new Lesson();
    lesson.description = lessonsXML.first.getAttribute("description");
    lesson.lesson_type = lessonsXML.first.getAttribute("lesson_type");

    Iterable<XmlElement> audioXMLNode =
        lessonsXML.first.findAllElements("audio_url");

    try {
      lesson.audio_url = audioXMLNode.first.text;
    } catch (e) {
      print(e);
    }

    slideXML = lessonsXML.first.findElements("slide");
    List<Slide> slideList = new List();

    for (XmlElement slideobj in slideXML) {
      // print("element" + slideobj.getAttribute("template").toString());

      Slide slide = new Slide();
      slide.background = slideobj.getAttribute("background");
      slide.fragmentCount = slideobj.getAttribute("fragmentCount");
      slide.image_bg = slideobj.getAttribute("image_bg");
      slide.slideType = slideobj.getAttribute("slideType");
      slide.template = slideobj.getAttribute("template");
      slide.slide_audio = getElemtValue(slideobj, "slide_audio", "slide");
      slide.imageUrl = getAttributeValue(slideobj, "img", "url");
      slide.id = int.parse(getElemtValue(slideobj, "id", "slide"));
      slide.order_id = int.parse(getElemtValue(slideobj, "order_id", "slide"));
      slide.p = getElemtValue(slideobj, "p", "slide");
      slide.duration = int.parse(getElemtValue(slideobj, "duration", "slide"));
      slide.h1 = getElemtValue(slideobj, "h1", "slide");
      slide.h2 = getElemtValue(slideobj, "h2", "slide");

      Iterable<XmlElement> interactiveXML =
          slideobj.findAllElements("interactive");
      if (interactiveXML.length != 0) {
        SlideInteratctive interatctive = new SlideInteratctive();

        Iterable<XmlElement> interactiveLIXML =
            interactiveXML.first.findElements("ul").first.findAllElements("li");
        SlideUL slideUL = new SlideUL();
        List<SlideLI> slideList = new List();
        for (XmlElement liObj in interactiveLIXML) {
          SlideLI slideLI = new SlideLI();
          slideLI.destination_slide =
              int.parse(liObj.getAttribute("destination_slide"));
          slideLI.is_correct_opt =
              liObj.getAttribute("is_correct_opt").toString() == "true"
                  ? true
                  : false;
          slideLI.coins = int.parse(liObj.getAttribute("coins"));
          slideLI.points = int.parse(liObj.getAttribute("points"));
          slideLI.transition_type = liObj.getAttribute("transition_type");
          slideLI.description = getElemtValue(liObj, "description", "li");
          slideLI.fragment_audio = getElemtValue(liObj, "fragment_audio", "li");
          slideLI.id = int.parse(getElemtValue(liObj, "id", "li"));
          slideLI.imageUrl = getAttributeValue(liObj, "img ", "url");
          slideLI.fragment_duration =
              int.parse(getElemtValue(liObj, "fragment_duration", "li"));
          slideList.add(slideLI);
        }
        slideUL.slideList = slideList;
        interatctive.slideUL = slideUL;
        slide.interatctive = interatctive;
      } else {
        Iterable<XmlElement> UlXML = slideobj.findAllElements("ul");
        if (UlXML.length != 0) {
          Iterable<XmlElement> lIXML = UlXML.first.findAllElements("li");
          SlideUL slideUL = new SlideUL();
          List<SlideLI> slideList = new List();
          for (XmlElement liObj in lIXML) {
            SlideLI slideLI = new SlideLI();
            slideLI.description = getElemtValue(liObj, "description", "li");
            slideLI.fragment_audio =
                getElemtValue(liObj, "fragment_audio", "li");
            slideLI.id = int.parse(getElemtValue(liObj, "id", "li"));
            slideLI.fragment_duration =
                int.parse(getElemtValue(liObj, "fragment_duration", "li"));
            slideList.add(slideLI);
          }
          slideUL.slideList = slideList;
          slide.slideUL = slideUL;
        }
      }
      slideList.add(slide);
    }
    lesson.slideLists = slideList;

    return lesson;
  }

  getAttributeValue(XmlElement element, String tagName, String attrName) {
    try {
      return element.document
          .findAllElements(tagName)
          .first
          .getAttribute(attrName);
    } catch (e) {
      return null;
    }
  }

  String getElemtValue(XmlElement element, String tagName, String parentTag) {
    try {
      Iterable<XmlElement> eleXML = element.document.findAllElements(tagName);
      for (XmlElement ele in eleXML) {
        XmlElement parent = ele.parent;
        if (parentTag.toString() == parent.name.toString()) {
          return ele.text.toString();
        }
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  printNode(XmlElement node) {}
}
