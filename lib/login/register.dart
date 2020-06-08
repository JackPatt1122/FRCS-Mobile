import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Stack(children: <Widget>[
          AnimatedPositioned(child: Container(decoration: BoxDecoration(color: Colors.white)),),
        ],),
      ),
    );
  }
}