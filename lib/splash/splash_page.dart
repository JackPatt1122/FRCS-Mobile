import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

double _padding = 50;

  @override
  void initState() {
  _padding = 50;
  Timer(const Duration(milliseconds: 1000), () {
        _padding = 10;

    });

} 

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Material(child: Scaffold(body: Container(
      child: Center(
        child: Container(
          
            child: AnimatedPadding(
          duration: Duration(milliseconds: 1000),
        
          padding: EdgeInsets.all(_padding),
          child: Image.asset('assets/icon.png'),
          
        )))),
      ),
    );
  }
}
