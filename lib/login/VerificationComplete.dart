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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(padding: EdgeInsets.only(top: 30, left: 12), child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
                          child: GestureDetector(
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0x29000000),
                                      offset: Offset(0, 0),
                                      blurRadius: 40)
                                ],
                              ),
                              child: Center(
                                child: Center(
                                  child: Icon(Icons.arrow_back, color: Colors.black,),
                                ),
                              ),
                            ),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                        ),
              ),
            ),
            
            Align(child: Padding(padding: EdgeInsets.only(top: 30), child: Text("Congradulations", style: TextStyle(color: Colors.black),),),)
          ],
        ),
      ),
    );
  }
}
