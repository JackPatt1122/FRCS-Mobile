import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'VerificationComplete.dart';
import 'package:page_transition/page_transition.dart';

class RegisterComplete extends StatefulWidget {
  @override
  _RegisterCompleteState createState() => _RegisterCompleteState();

  String text = "Test123456";

  RegisterComplete({Key key, @required this.text}) : super(key: key);
}

class _RegisterCompleteState extends State<RegisterComplete> {
  double _padding;
  double _size = 100;
  double _opacity = 1;
  bool isTrue = false;
  Timer timer;

  BorderRadiusGeometry _borderRadius = BorderRadius.circular(20);

  @override
  void initState() {
    _padding = 20;
    _size = 100;
    _opacity = 1;
    isTrue = false;
    _borderRadius = BorderRadius.circular(20);
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getTeamData());
  }

  changeSizeBigger() {
    setState(() {
      _padding = 20;
      _size = 120;
    });
  }

  changeSizeBigger2() {
    setState(() {
      _padding = 30;
      _size = 1000;
      _opacity = 0;
      _borderRadius = BorderRadius.circular(0);
    });
  }

  changeSizeSmaller() {
    setState(() {
      _padding = 20;
      _size = 80;
    });
  }

  animationSequence() {
    Timer(const Duration(milliseconds: 10), () {
      changeSizeBigger();
      Timer(const Duration(milliseconds: 1000), () {
        changeSizeSmaller();
        Timer(const Duration(milliseconds: 1000), () {
          changeSizeBigger2();
        });
      });
    });
  }

  Future getTeamData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + 'test123456'),
        headers: {
          "Accept": "application/json",
        });
    if (json.decode(response.body)['is_active'] == true && isTrue == false) {
      animationSequence();
      setState(() {
        isTrue = true;
      });
                                         Timer(const Duration(milliseconds: 2500), () {

      Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: VerifyComplete(),
          ));
                                         });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      backgroundColor: Color(0xFFF1F3F6),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedPadding(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.only(top: 30),
              child: Text(
                "Your account has been created",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins-Medium',
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
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
                    padding: EdgeInsets.all(_padding),
                    child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: _opacity,
                        child: Image.asset('assets/icon.png'))),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .3),
                      offset: Offset(30, 30),
                      blurRadius: 60)
                ], color: Color(0xFFF1F3F6), borderRadius: _borderRadius)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: _opacity,
                    child: Text(
                      "Click the link in the email to verify your account",
                      style: TextStyle(color: Colors.black),
                    ))),
          ),
        ],
      ),
    ));
  }
}
