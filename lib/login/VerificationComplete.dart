import 'package:flutter/material.dart';

class VerifyComplete extends StatefulWidget {
  @override
  _VerifyCompleteState createState() => _VerifyCompleteState();
}

class _VerifyCompleteState extends State<VerifyComplete> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
                backgroundColor: Color(0xFFF1F3F6),

        body: Column(
          children: <Widget>[
            Align(child: Padding(padding: EdgeInsets.only(top: 30), child: Text("Congradulations", style: TextStyle(color: Colors.black),),),)
          ],
        ),
      ),
    );
  }
}
