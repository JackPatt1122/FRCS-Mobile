import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'RegisterSuccess.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double _topPadding = 300;
  double _size = 100;
  Alignment _alignment;
  double _innerPadding = 20;

  double _leftPadding = 25;
  double _textOpacity = 0;

  double _opacity = 0;

  String username;
  int team_num;
  String password;
  String email;
  bool is_admin;

  final usernameController = TextEditingController();
  final teamNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  _changePadding() {
    setState(() {
      _topPadding = 40;
    });
  }

    _changePadding2() {
    setState(() {
      _topPadding = 0;
    });
  }

  _changeTextPadding() {
    setState(() {
      _leftPadding = 12;
    });
  }

  _changeTextOpacity() {
    setState(() {
      _textOpacity = 1;
    });
  }

  _changeInnerPadding() {
    setState(() {
      _innerPadding = 40;
    });
  }

  _changeInnerPadding2() {
    setState(() {
      _innerPadding = 20;
    });
  }

  _changeSize() {
    setState(() {
      _size = 200;
    });
  }

  _changeAlign() {
    setState(() {
      _alignment = Alignment.topCenter;
    });
  }

  _changeAlign2() {
    setState(() {
      _alignment = Alignment.center;
    });
  }

  _changeSize2() {
    setState(() {
      _size = 100;
    });
  }

  _changeOtherOpacity() {
    setState(() {
      _opacity = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _topPadding = 0;
    _alignment = Alignment.center;
    _leftPadding = 25;
    _textOpacity = 0;
    Timer(const Duration(milliseconds: 1000), () {
      _changeSize();
      _changeInnerPadding();

      Timer(const Duration(milliseconds: 1000), () {
        _changeInnerPadding2();
        _changeSize2();
        _changeAlign();
        _changePadding();
        Timer(const Duration(milliseconds: 1000), () {
          _changeTextPadding();
          _changeTextOpacity();
          Timer(const Duration(milliseconds: 1000), () {
            _changeOtherOpacity();
          });
        });
      });
    });
  }

  bool isChecked = false;

  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      // Put your code here which you want to execute on CheckBox Checked event.
      setState(() {
        isChecked = true;
      });
    } else {
      // Put your code here which you want to execute on CheckBox Un-Checked event.
      setState(() {
        isChecked = false;
      });
    }
  }

  sendRegistrationData() {
    http.post(Uri.encodeFull("http://192.168.86.37:8000/api/createuser/"),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6',
        },
        body: {
          "email": "test@test.com",
          "password": "password12",
          "team_num": "810",
          "username": "test123456",
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Color(0xFFF1F3F6),
        body: Stack(
          children: <Widget>[
            AnimatedAlign(
              curve: Curves.easeInOutExpo,
              duration: Duration(milliseconds: 1000),
              alignment: _alignment,
              child: AnimatedPadding(
                curve: Curves.easeInOutExpo,
                padding: EdgeInsets.only(top: _topPadding),
                duration: Duration(milliseconds: 1000),
                child: AnimatedContainer(
                    curve: Curves.easeInOutExpo,
                    duration: Duration(
                      milliseconds: 1000,
                    ),
                    height: _size,
                    width: _size,
                    child: AnimatedPadding(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.all(_innerPadding),
                        child: Image.asset('assets/icon.png')),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, .3),
                              offset: Offset(30, 30),
                              blurRadius: 60)
                        ],
                        color: Color(0xFFF1F3F6),
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AnimatedPadding(
                        curve: Curves.easeInOutExpo,
                        duration: Duration(milliseconds: 500),
                        padding: EdgeInsets.only(top: 170, left: _leftPadding),
                        child: AnimatedOpacity(
                          opacity: _textOpacity,
                          duration: Duration(milliseconds: 300),

                            
                              
                              child: Text(
                                "Welcome To FRCS",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontFamily: 'Poppins-Light',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                  
                      AnimatedPadding(
                          curve: Curves.easeInOutExpo,
                          duration: Duration(milliseconds: 600),
                          padding: EdgeInsets.only(left: _leftPadding),
                          child: AnimatedOpacity(
                            opacity: _textOpacity,
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: Duration(milliseconds: 500),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                            ),
                            controller: emailController,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Username",
                              labelStyle: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                            ),
                            controller: usernameController,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                            ),
                            controller: passwordController,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Team Number",
                              labelStyle: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                            ),
                            controller: teamNumberController,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(children: <Widget>[
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  toggleCheckbox(value);
                                },
                                activeColor: Colors.pink,
                                checkColor: Colors.white,
                                hoverColor: Colors.red,
                                tristate: false,
                              ),
                              Text(
                                "Team Admin?",
                                style: TextStyle(color: Colors.black),
                              )
                            ]),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: FlatButton(
                              onPressed: () {
                                Timer(const Duration(milliseconds: 100), () {
                                  _changeAlign2();
                                  _changePadding2();
                                   Timer(const Duration(milliseconds: 2000), () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child:
                                            RegisterComplete(text: usernameController.text)));

                                   });
                                });
                                

                                //sendRegistrationData();
                              },
                              padding: EdgeInsets.all(0),
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xff8A2387),
                                      Color(0xffE94057),
                                      Color(0xffF27121),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  constraints: BoxConstraints(
                                      maxWidth: double.infinity, minHeight: 50),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
