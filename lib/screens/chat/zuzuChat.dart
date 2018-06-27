// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:android_istar_app/models/chat/aiAndroidResponse.dart';
import 'package:android_istar_app/models/chat/aiBotAndroidAction.dart';
import 'package:android_istar_app/utils/customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.isMe, this.animationController});
  final String text;
  final AnimationController animationController;

  final bool isMe;
  static DateTime now = new DateTime.now();
  final String time = now.hour.toString() + " : " + now.minute.toString();
  final delivered = true;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? CustomColors.bot_sender_color : Colors.white;
    final textColor = isMe ? Colors.black : Colors.black;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );

    Widget bubble;

    if (isMe) {
      bubble = new Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(.12))
              ],
              color: bg,
              borderRadius: radius,
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 4.0, right: 20.0),
                  child: Text(
                    text,
                    style: new TextStyle(color: textColor),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Row(
                    children: <Widget>[
                      Text("",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 10.0,
                          )),
                      new SizedBox(
                        width: 3.0,
                      ),
                      Icon(
                        icon,
                        size: 12.0,
                        color: Colors.black38,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    } else {
      bubble = new Column(
        crossAxisAlignment: align,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new AssetImage("assets/images/chatbot.jpg")))),
              new Padding(padding: const EdgeInsets.only(left: 3.0)),
              new Text(
                "Zu",
                style: new TextStyle(fontSize: 12.0),
              )
            ],
          ),
          new Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(.12))
              ],
              color: bg,
              borderRadius: radius,
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 4.0, right: 20.0),
                  child: Text(
                    text,
                    style: new TextStyle(color: textColor),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Row(
                    children: <Widget>[
                      Text("",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 10.0,
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[bubble]));
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  String transcription = '';
  String _currentLocale = 'en_IN';

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  void _handleUserSubmitted(String text) {
    _makeQuery(text);

    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      isMe: true,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  void _handleZuZuSubmitted(String text) {
    ChatMessage message = new ChatMessage(
      text: text,
      isMe: false,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  void _makeQuery(text) async {
    var url = "http://business.talentify.in:9090/ai/simple-ai";
    var client = new http.Client();
    var request = new http.Request('POST', Uri.parse(url));
    var body = {'query': text.toString(), 'istarUserID': "27"};
    request.bodyFields = body;
    client
        .send(request)
        .then((response) => response.stream
            .bytesToString()
            .then((value) => _onSuccessQuery(value)))
        .catchError((error) => print("Error---" + error.toString()));
  }

  void _onSuccessQuery(responseBody) async {
    print("Success---" + responseBody.toString());
    List aiAndroidResponseMap = json.decode(responseBody);
    for (Map data in aiAndroidResponseMap) {
      AIAndroidResponse aiResponse = new AIAndroidResponse.fromJson(data);
      if (data.containsKey("actionItems")) {
        List aiBotMap = data["actionItems"];
        if (aiBotMap != null && aiBotMap.length != 0) {
          List<AIBotAndroidAction> actionItems = new List();
          for (Map botMap in aiBotMap) {
            AIBotAndroidAction aiBotAction =
                new AIBotAndroidAction.fromJson(botMap);
            actionItems.add(aiBotAction);
          }
          aiResponse.actionItems = actionItems;
        }
      }
      debugPrint(aiResponse.type);
      if (aiResponse.type == "Mitsuku") {
        _handleZuZuSubmitted(aiResponse.description);
      }
    }
  }

  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleUserSubmitted,
                decoration: new InputDecoration.collapsed(
                    hintText: "Type message here"),
              ),
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? new IconButton(
                        icon: new Icon(
                          _textController.text.length == 0
                              ? Icons.mic
                              : Icons.send,
                          color: CustomColors.theme_color,
                        ),
                        onPressed: () {
                          if (_textController.text.length == 0) {
                            startMicListening();
                          } else if (_isComposing) {
                            _handleUserSubmitted(_textController.text);
                          }
                        },
                      )
                    : new IconButton(
                        icon: new Icon(
                            _textController.text.length == 0
                                ? Icons.mic
                                : Icons.send,
                            color: CustomColors.theme_color),
                        onPressed: () {
                          if (_textController.text.length == 0) {
                            startMicListening();
                          } else if (_isComposing) {
                            _handleUserSubmitted(_textController.text);
                          }
                        },
                      )),
          ]),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))
              : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.theme_color,
        elevation: .9,
        automaticallyImplyLeading: true,
        titleSpacing: 0.0,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
                width: 30.0,
                height: 30.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage("assets/images/chatbot.jpg")))),
            new Padding(padding: const EdgeInsets.only(left: 3.0)),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text('Zu',
                    style: TextStyle(color: Colors.white, fontSize: 14.0)),
                new Text('Always Availabel for you',
                    style: TextStyle(color: Colors.white, fontSize: 10.0))
              ],
            )
          ],
        ),
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: new Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
          image: new AssetImage("assets/images/chat_bg_image.png"),
          fit: BoxFit.cover,
        )),
        child: new Column(children: <Widget>[
          new Flexible(
              child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          )),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ]),
      ), //new
    );
  }

  void activateSpeechRecognizer() async {
    //await SimplePermissions.requestPermission(Permission.RecordAudio);

    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  void startListening() =>
      _speech.listen(locale: _currentLocale).then((result) => print(''));

  void cancelListening() =>
      _speech.cancel().then((result) => setState(() => _isListening = result));

  void stopListening() =>
      _speech.stop().then((result) => setState(() => _isListening = result));

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) =>
      setState(() => _currentLocale = locale);

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) => _recognRes(text);

  void onRecognitionComplete() => _handleData();

  _handleData() {
    setState(() => _isListening = false);
  }

  startMicListening() {
    transcription = "";
    startListening();
  }

  _recognRes(String text) {
    setState(() => transcription = text);
    if (!_isListening) if (transcription.length != 0)
      _handleUserSubmitted(transcription);
  }
}
