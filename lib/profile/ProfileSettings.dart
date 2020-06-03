import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        Container(
            child: 
            Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold'),
                )),
        ),
      ],
    ));
  }
}
