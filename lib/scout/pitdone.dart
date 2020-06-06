import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PitDone extends StatefulWidget {
  @override
  _PitDoneState createState() => _PitDoneState();
}

class _PitDoneState extends State<PitDone> {
  double _topPadding = 15;
  double _opacity = 0;
  double _size = 100;
  double _iconSize = 50;
  

  _changePadding() {
    setState(() {
      _topPadding = 30;
    });
  }

  _changeOpacity() {
    setState(() {
      _opacity = 1;
    });
  }

  _changeSize() {
    setState(() {
      _size = 150;
    });
  }

    _changeIconSize() {
    setState(() {
      _iconSize = 100;
    });
  }

  @override
  void initState() {
    _topPadding = 15;
    Timer(const Duration(milliseconds: 200), () {
      _changePadding();
      _changeOpacity();
      _changeSize();
      _changeIconSize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 244, 251, 1),
      body: Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: AnimatedPadding(
                    padding: EdgeInsets.only(top: _topPadding),
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOutExpo,
                    child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutExpo,
                      child: Text(
                        "Pit Data Submitted",
                        style:
                            TextStyle(fontSize: 30, fontFamily: 'Poppins-Bold'),
                      ),
                    )),
              ),
              Align(
                  alignment: Alignment.center,
                  child:AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOutExpo,
                    height: _size,
                    width: _size,
                    child: AnimatedContainer(duration: Duration(milliseconds: 500), child: Icon(
                      Icons.check,
                      size: _iconSize,
                    )),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(241, 244, 251, 1),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 0),
                              blurRadius: 40)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                  )),
                  Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedPadding(
                    padding: EdgeInsets.only(bottom: 65, left: 12, right: 12),
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOutExpo,
                    child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutExpo,
                      child:  Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Color.fromRGBO(233, 64, 87, 1),
                              ),
                              child: GestureDetector(
                                child: Center(
                                  child: Text(
                                    "View Entry Data",
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ),
                                onTap: () {},
                              )),
                  ))),
                  Align(
                  alignment: Alignment.bottomCenter, child: Padding(padding: EdgeInsets.only(left: 12, right: 12, bottom:  12), child: 
                  Row(                mainAxisAlignment: MainAxisAlignment.spaceBetween,
 children: <Widget>[
                     Container(
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Colors.black,
                              ),
                              child: GestureDetector(
                                child: Center(
                                  child: Text(
                                    "Submit Another",
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ),
                                onTap: () {},
                              )),
                               Container(
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Colors.black,
                              ),
                              child: GestureDetector(
                                child: Center(
                                  child: Text(
                                    "Go To Profile",
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ),
                                onTap: () {},
                              )),
                              
                  ],)))
            ],
          )),
    );
  }
}
