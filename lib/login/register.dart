import 'package:flutter/material.dart';
import 'dart:async';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


double _topPadding = 200;

          _changePadding() {
      setState(() {
        _topPadding = 100;
      });
    
  }

    @override
    void initState() {
      super.initState();
      _topPadding = 200;
          Timer(const Duration(milliseconds: 1000), () {
            _changePadding();
          });

    }


  @override
  Widget build(BuildContext context) {
    


    return Material(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            AnimatedPadding(
              padding: EdgeInsets.only(top: _topPadding),
              duration: Duration(milliseconds: 500),
              child: AnimatedContainer(
                  duration: Duration(
                    milliseconds: 500,
                  ),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
