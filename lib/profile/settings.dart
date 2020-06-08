import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}




class _SettingsState extends State<Settings> {

  bool isSwitched = false;



    setTheme(){
    return isSwitched;
  }

  @override
  Widget build(BuildContext context) {
    return Material( child: Container(
      child: Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
    ),
    );
  }
}