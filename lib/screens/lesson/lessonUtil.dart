import 'package:android_istar_app/models/lesson/lesson.dart';
import 'package:android_istar_app/models/lesson/slide.dart';
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

    slideXML = lessonsXML.first.document.findAllElements("slide");
    List<Slide> slideList = new List();

    for (XmlElement slideobj in slideXML) {
      print("element" + slideobj.getAttribute("template"));
      Slide slide = new Slide();
      slide.background = slideobj.getAttribute("background");
      slide.fragmentCount = slideobj.getAttribute("fragmentCount");
      slide.image_bg = slideobj.getAttribute("image_bg");
      slide.slideType = slideobj.getAttribute("slideType");
      slide.template = slideobj.getAttribute("template");
      slide.slide_audio = getElemtValue(slideobj, "slide_audio");
      slide.imageUrl = getAttributeValue(slideobj, "img", "url");
      slide.id = int.parse(getElemtValue(slideobj, "id"));
      slide.order_id = int.parse(getElemtValue(slideobj, "order_id"));
      slide.p = getElemtValue(slideobj, "p");
      slide.duration = int.parse(getElemtValue(slideobj, "duration"));
      slide.h1 = getElemtValue(slideobj, "h1");
      slide.h2 = getElemtValue(slideobj, "h2");

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

  String getElemtValue(XmlElement element, String tagName) {
    try {
      return element.document.findAllElements(tagName).first.text;
    } catch (e) {
      return null;
    }
  }
}
