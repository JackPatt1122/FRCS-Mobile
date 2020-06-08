import 'package:flutter/material.dart';

class RegisterComplete extends StatefulWidget {
  @override
  _RegisterCompleteState createState() => _RegisterCompleteState();
}

class _RegisterCompleteState extends State<RegisterComplete> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Stack(children: <Widget>[
          Align(alignment: Alignment.topCenter, child: AnimatedPadding(duration: Duration(milliseconds: 500), padding: EdgeInsets.only(top: 30),))
        ],),
      )
    );
  }
}