import 'package:android_istar_app/models/studentProfile.dart';
import 'package:android_istar_app/models/tasksObject.dart';
import 'package:android_istar_app/utils/databaseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:android_istar_app/utils/customcolors.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  double screenHeight, screenWidth;
  String _password, _email;

  bool _obscureText = true;
  bool _showErrorLabel = false;
  String _errorText;
  Color passwordTintColor = CustomColors.theme_color;
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    // print("width--------" + screenWidth.toString());
    // print("height--------" + screenHeight.toString());

    return new MaterialApp(
      home: new Scaffold(
        key: scaffoldState,
        body: new Container(
            child: new Theme(
                data: new ThemeData(
                    primaryColor: CustomColors.theme_color,
                    accentColor: Colors.orange,
                    hintColor: CustomColors.pure_grey),
                child: new ListView(
                  physics: new NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 30.0),
                      constraints: new BoxConstraints.expand(height: 640.0),
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          new Text("Welcome back! Ready to get some work done?",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.black_color,
                              )),
                          new Divider(
                            color: Colors.white,
                            height: 25.0,
                          ),
                          new Form(
                              key: formKey,
                              child: new Column(children: [
                                new TextFormField(
                                    maxLines: 1,
                                    keyboardType: TextInputType
                                        .emailAddress, // Use email input type for emails.

                                    onSaved: (val) => _email = val,
                                    validator: (val) =>
                                        !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                                .hasMatch(val)
                                            ? 'Not a valid email.'
                                            : null,
                                    decoration: new InputDecoration(
                                        hintText: 'Email ID',
                                        border: new OutlineInputBorder())),
                                new Divider(
                                  color: Colors.white,
                                  height: 10.0,
                                ),
                                new TextFormField(
                                    obscureText: _obscureText,
                                    onSaved: (val) => _password = val,
                                    validator: (val) => val.length < 4
                                        ? 'Password too short.'
                                        : null,
                                    decoration: new InputDecoration(
                                        hintText: 'Password',
                                        border: const OutlineInputBorder(),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            _passwordToggle();
                                          },
                                          child: _obscureText
                                              ? const Icon(Icons.remove_red_eye,
                                                  color:
                                                      CustomColors.grey_color)
                                              : const Icon(Icons.remove_red_eye,
                                                  color:
                                                      CustomColors.theme_color),
                                        ))),
                                _showErrorLabel
                                    ? new Container(
                                        width: screenWidth - 30,
                                        padding: const EdgeInsets.all(10.0),
                                        margin:
                                            const EdgeInsets.only(bottom: 10.0),
                                        color: CustomColors.err_bg_color,
                                        child: new Text(
                                          _errorText,
                                          textAlign: TextAlign.left,
                                          style: new TextStyle(
                                              fontSize: 14.0,
                                              color: CustomColors.err_color),
                                        ),
                                      )
                                    : new Container(
                                        child: new Divider(
                                        color: Colors.white,
                                      )),
                                new Container(
                                    width: screenWidth - 30,
                                    height: 45.0,
                                    child: new RaisedButton(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)),
                                        onPressed: _handleLogin,
                                        elevation: 5.0,
                                        color: CustomColors.theme_color,
                                        textColor: Colors.white,
                                        child: new Text(
                                          'LOG IN',
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                new Divider(
                                  color: Colors.transparent,
                                  height: 5.0,
                                ),
                                new RaisedButton(
                                    elevation: 0.0,
                                    textColor: CustomColors.grey_color,
                                    color: Colors.transparent,
                                    onPressed: () {},
                                    child: new Text(
                                      'Forgot password?',
                                      style: new TextStyle(
                                          color: CustomColors.grey_color,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ])),
                          new Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Container(
                                      width: (screenWidth / 2) - 50,
                                      color: CustomColors.grey_color,
                                      height: 1.0,
                                    ),
                                    new Container(
                                        height: 25.0,
                                        decoration: new ShapeDecoration(
                                            color: CustomColors.grey_color,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0))),
                                        padding: const EdgeInsets.only(
                                            left: 3.0,
                                            right: 3.0,
                                            bottom: 3.0,
                                            top: 3.0),
                                        margin: const EdgeInsets.only(
                                            left: 1.0,
                                            right: 1.0,
                                            bottom: 1.0,
                                            top: 1.0),
                                        child: new Align(
                                            alignment: Alignment.center,
                                            child: Text("OR",
                                                textAlign: TextAlign.center,
                                                style: new TextStyle(
                                                    color: CustomColors
                                                        .black_color)))),
                                    new Container(
                                      width: (screenWidth / 2) - 50,
                                      color: CustomColors.grey_color,
                                      height: 1.0,
                                    )
                                  ])),
                          new Container(
                              margin:
                                  const EdgeInsets.only(top: 10.0, bottom: 6.0),
                              child: new Text("Log In via social media",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.black_color,
                                  ))),
                          new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new SizedBox(
                                    height: 70.0,
                                    width: 70.0,
                                    child: new GestureDetector(
                                        onTap: _handleLkClick,
                                        child: new Container(
                                            margin: const EdgeInsets.only(
                                                top: 5.0,
                                                left: 5.0,
                                                right: 5.0),
                                            child: new Image.asset(
                                                'assets/ic_linkedin.png',
                                                fit: BoxFit.scaleDown)))),
                                new SizedBox(
                                    height: 70.0,
                                    width: 70.0,
                                    child: new GestureDetector(
                                        onTap: _handleGoClick,
                                        child: new Container(
                                            margin: const EdgeInsets.only(
                                                top: 5.0,
                                                left: 5.0,
                                                right: 5.0),
                                            child: new Image.asset(
                                                'assets/google.png',
                                                fit: BoxFit.scaleDown)))),
                                new SizedBox(
                                    height: 70.0,
                                    width: 70.0,
                                    child: new GestureDetector(
                                        onTap: _handleFbClick,
                                        child: new Container(
                                            margin: const EdgeInsets.only(
                                                top: 5.0,
                                                left: 5.0,
                                                right: 5.0),
                                            child: new Image.asset(
                                              'assets/facebook.png',
                                              fit: BoxFit.scaleDown,
                                            )))),
                              ]),
                          new Container(
                              margin: const EdgeInsets.all(10.0),
                              child: new Text("Not a member? Register instead",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.grey_color,
                                  )))
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }

  void _passwordToggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _handleLogin() {
    setState(() {
      _showErrorLabel = false;
    });

    final form = formKey.currentState;
    if (form.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      } catch (e) {
        debugPrint(e.toString());
      }

      form.save();
      print("email:" + _email + " password:" + _password);
      scaffoldState.currentState.showSnackBar(new SnackBar(
        backgroundColor: CustomColors.theme_color,
        content: new Text("Logging In"),
      ));
      _makeLogin();
    }
  }

  void _handleFbClick() {
    print("fb login");
  }

  void _handleLkClick() {
    print("LinkedIn login");
  }

  void _handleGoClick() {
    print("google login");
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed

    super.dispose();
  }

  void _makeLogin() async {
    var url = "http://business.talentify.in:9090/istar/rest/auth/login";
    var client = new http.Client();
    var request = new http.Request('POST', Uri.parse(url));
    var body = {'email': _email, 'password': _password};
    request.bodyFields = body;
    client
        .send(request)
        .then((response) => response.stream
            .bytesToString()
            .then((value) => _onSuccessLogin(value, context)))
        .catchError((error) => print("Error---" + error.toString()));
  }

  _onSuccessLogin(responseBody, context) async {
    print("Success---" + responseBody.toString());
    if (responseBody.toString().contains("istarViksitProComplexKey")) {
      Map<String, dynamic> parsedMap = json.decode(responseBody);
      setState(() {
        _showErrorLabel = true;
        _errorText = parsedMap['istarViksitProComplexKey'];
      });
    } else {
      Map studentMap = json.decode(responseBody)['studentProfile'];
      StudentProfile studentProfile = new StudentProfile.fromJson(studentMap);
      print('Howdy, ${studentProfile.id}!');

      List taskMaps = json.decode(responseBody)['tasks'];
      print(taskMaps.length);
      for (Map items in taskMaps) {
        Tasks task = new Tasks.fromJson(items);
        print('task, ${task.itemType}');
        if (task.id != null) {
          TasksProvider tasksProvider = await new DbHelper().getTasksProvide();
          await tasksProvider.insert(task);
        }
      }

      StudentProfileProvider profileProvider =
          await new DbHelper().getUserProvide();
      await profileProvider.insert(studentProfile);
      Navigator.of(_context).pushReplacementNamed("/splash");
    }
  }
}
