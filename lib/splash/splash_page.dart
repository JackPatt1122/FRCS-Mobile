import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(child: Image.asset('assets/icon.png'), height: 200, width: 200,)
      ),
    );
  }
}
