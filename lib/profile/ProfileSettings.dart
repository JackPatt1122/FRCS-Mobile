import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();

  final String text;

  ProfileSettings({Key key, @required this.text}) : super(key: key);
}

class _ProfileSettingsState extends State<ProfileSettings> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
 


   Future updateProfile() async {
      
    var response = await http.patch(
      

        Uri.encodeFull("http://192.168.86.37:8000/api/profile/" + widget.text + "/"),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6',
          
        },
        body: {'first_name': firstNameController.text, "last_name": lastNameController.text},
        );

    return Future.value(json.decode(response.body));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 30, 0, 0),
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
          child: Padding(
              padding: EdgeInsets.only(left: 12, top: 70),
              child: Text(
                "Edit Profile",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins-Bold',
                    color: Color.fromRGBO(102, 102, 102, 1)),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 100),
          child: TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(
                labelText: 'First Name',
                labelStyle: TextStyle(color: Color.fromRGBO(193, 193, 193, 1))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 170),
          child: TextFormField(
            controller: lastNameController,
            decoration: InputDecoration(
                labelText: 'Last Name',
                labelStyle: TextStyle(color: Color.fromRGBO(193, 193, 193, 1))),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12, 260, 12, 0),
          child: Container(
            height: 50,
            width: double.infinity,
            child: FlatButton(
              onPressed: () { updateProfile(); },
              padding: EdgeInsets.all(0),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color.fromRGBO(233, 64, 87, 1)
                ),
                child: Container(
                  alignment: Alignment.center,
                  constraints:
                      BoxConstraints(maxWidth: double.infinity, minHeight: 50),
                  child: Text(
                    "Update Profile",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
