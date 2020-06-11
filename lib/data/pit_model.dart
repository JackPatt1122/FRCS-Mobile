import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:sliding_sheet/sliding_sheet.dart';

class ListDetail extends StatefulWidget {
  final String text;

  ListDetail({Key key, @required this.text}) : super(key: key);

  ListDetailState createState() => ListDetailState();
}

class ListDetailState extends State<ListDetail> {
  void showAsBottomSheet() async {
    final result = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        duration: Duration(milliseconds: 300),
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.8, 0.8],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return Material(
            child: Container(
              height: 700,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 7,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey),
                          )),
                      
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: Text("Country",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 15)),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                            child: FutureBuilder<dynamic>(
                              future: getTeamData(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return Text('${snapshot.data['nickname']}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: 13));
                                return Text("Loading",
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 15,
                                        color: Colors.white));
                              },
                            ),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: Text("Region",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 15)),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                            child: FutureBuilder<dynamic>(
                              future: getTeamData(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return Text('${snapshot.data['state_prov']}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: 13));
                                return Text(" ");
                              },
                            ),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: Text("City",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 15)),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                            child: FutureBuilder<dynamic>(
                              future: getTeamData(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return Text('${snapshot.data['city']}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: 13));
                                return Text(" ");
                              },
                            ),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: Text("School",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 15)),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                            child: FutureBuilder<dynamic>(
                              future: getTeamData(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return Text('${snapshot.data['school_name']}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: 13));
                                return Text(" ");
                              },
                            ),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: Text("Rookie Year",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 15)),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                            child: FutureBuilder<dynamic>(
                              future: getTeamData(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return Text('${snapshot.data['rookie_year']}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: 13));
                                return Text(" ");
                              },
                            ),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: Text("Competitions",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 15)),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 5, 12, 12),
                            child: FutureBuilder<dynamic>(
                              future: getCompData(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return Text('${snapshot.data[0]['name']}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: 13));
                                return Text(" ");
                              },
                            ),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: Text("Home Champs",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 15)),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                            child: FutureBuilder<dynamic>(
                              future: getTeamData(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return Text(
                                      '${snapshot.data['home_championship']['2020']}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: 13));
                                return Text(" ");
                              },
                            ),
                          )),
                    ],
                  )),
            ),
          );
        },
      );
    });

    print(result); // This is the result.
  }

  double _width;
  Color _color;
  IconData _icon;

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/pit/" + widget.text),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body));
  }

  Future getAutoData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/pit/" + widget.text),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body)['robot_autonomous']);
  }

  Future getClimbData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/pit/" + widget.text),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body)['robot_buddy_climb']);
  }

  Future getBuddyData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/pit/" + widget.text),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body)['robot_climb']);
  }

  Future flagData() async {
    var response = await http.patch(
      Uri.encodeFull("http://192.168.86.37:8000/api/pit/" + widget.text + "/"),
      headers: {
        "Accept": "application/json",
        'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6',
      },
      body: {'is_incorrect': 'true'},
    );

    return Future.value(json.decode(response.body));
  }

  Future getPosData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/pit/" + widget.text),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body)['robot_control_panel_pos']);
  }

  Future getEntryValidity() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/pit/" + widget.text),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body)['is_incorrect']);
  }

  Future getRotData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/pit/" + widget.text),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body)['robot_control_panel_rot']);
  }


  
  

  Future getValidity() async {
    var data = await getEntryValidity();
    if (data == true) {
      return "! This data Is Incorrect !";
    }
    if (data == false) {
      return " ";
    }
    return data;
  }

  Future getAuto() async {
    var data = await getAutoData();
    if (data == "0") {
      return "No";
    }
    if (data == "100") {
      return "Yes";
    }
    return data;
  }

  Future getClimb() async {
    var data = await getClimbData();
    if (data == "0") {
      return "No";
    }
    if (data == "100") {
      return "Yes";
    }
    return data;
  }

  Future getBuddy() async {
    var data = await getBuddyData();
    if (data == "0") {
      return "No";
    }
    if (data == "100") {
      return "Yes";
    }
    return data;
  }

  Future getRot() async {
    var data = await getRotData();
    if (data == "0") {
      return "No";
    }
    if (data == "100") {
      return "Yes";
    }
    return data;
  }

  Future getPos() async {
    var data = await getPosData();
    if (data == "0") {
      return "No";
    }
    if (data == "100") {
      return "Yes";
    }
    return data;
  }

  double _leftPadding = 25;
  double _opacity = 0;
  double  _height = 0;

  _changePadding() {
    setState(() {
      _leftPadding = 12;
    });
  }

  _changeOpacity() {
    setState(() {
      _opacity = 1;
    });
  }

   _changeHeight() {
    setState(() {
      _height = 180;
    });
  }

  @override
  void initState() {
    super.initState();
    _width = 30;
    _color = Colors.black;
    _icon = Icons.error;
    _leftPadding = 25;
    _opacity = 0;
    Timer(const Duration(milliseconds: 1000), () {
      _changePadding();
      _changeOpacity();
            _changeHeight();

    });
  }

  Future getTeamData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://www.thebluealliance.com/api/v3/team/frc" + widget.text),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    return Future.value(json.decode(response.body));
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Flag Data"),
            content: new Text("This data will be marked as incorrect"),
            actions: <Widget>[
              new FlatButton(
                color: Color.fromRGBO(233, 64, 87, 1),
                child: new Text("Flag"),
                onPressed: () {
                  flagData();
                },
              ),
              new FlatButton(
                child: new Text("Close", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }



  Future getCompData() async {
    var response = await http.get(
        Uri.encodeFull("https://www.thebluealliance.com/api/v3/team/frc" +
            widget.text +
            "/events/2020"),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    return Future.value(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).backgroundColor;

          getColor() {
    print(color);
    return color;
  }


        iconColor(){
    if(getColor() == Colors.black){
      return Colors.white;
    }
    else{
      return Colors.black;
    }
  }

    return Scaffold(
      body:  SafeArea(child: Container(
        child: ListView(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: _height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7)),
                  color: Color.fromRGBO(233, 64, 87, 1),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 0),
                        blurRadius: 40)
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
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
                                  child: Icon(Icons.arrow_back, color: iconColor(),),
                                ),
                              ),
                            ),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 12, 10),
                          child: GestureDetector(
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Interval(
                                  0.125,
                                  0.250,
                                  curve: Curves.easeInOutExpo,
                                ),
                                height: 30,
                                width: _width,
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
                                child: Icon(
                                  _icon,
                                  color: _color,
                                ),
                              ),
                              onTap: () => _showDialog()),
                        ),
                      ],
                    ),
                    AnimatedPadding(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOutExpo,
                      padding: EdgeInsets.fromLTRB(_leftPadding, 40, 0, 0),
                      child: FutureBuilder<dynamic>(
                        future: getTeamData(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return AnimatedOpacity(
                                opacity: _opacity,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOutExpo,
                                child: Text('${snapshot.data['nickname']}',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 20,
                                        color: Colors.white)));
                          return Text(" ");
                        },
                      ),
                    ),
                    AnimatedPadding(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOutExpo,
                      padding: EdgeInsets.fromLTRB(_leftPadding, 65, 0, 0),
                      child: AnimatedOpacity(
                          opacity: _opacity,
                          duration: Duration(milliseconds: 550),
                          curve: Curves.easeInOutExpo,
                          child: Text(
                            "Team " + widget.text,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ),
                    AnimatedPadding(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOutExpo,
                      padding: EdgeInsets.only(left: _leftPadding, top: 90),
                      child: FutureBuilder<dynamic>(
                        future: getValidity(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return AnimatedOpacity(
                                opacity: _opacity,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOutExpo,
                                child: Text('${snapshot.data}',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.white)));
                          return Text(" ");
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 20, left: 12, right: 12, top: 120),
                          child: AnimatedOpacity(
                                opacity: _opacity,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOutExpo,
                                child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                color: Colors.white,
                              ),
                              child: GestureDetector(
                                child: Center(
                                  child: AnimatedOpacity(
                                opacity: _opacity,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOutExpo,
                                child: Text(
                                    "Team Information",
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Color.fromRGBO(233, 64, 87, 1)),
                                  )),
                                ),
                                onTap: () => showAsBottomSheet(),
                              ))),
                        )),
                  ],
                )),
            Container(
              height: 700,
              child: Center(
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 5, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 650),
                            curve: Curves.easeInOutExpo,
                            child: Text("Competition",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 20))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getData(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 700),
                                    curve: Curves.easeInOutExpo,
                                    child: Text(
                                        '${snapshot.data['competition']}'.replaceAll('***SUSPENDED***', ''),
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 15)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 750),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot Weight",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 850),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getData(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 800),
                                    curve: Curves.easeInOutExpo,
                                    child: Text(
                                        '${snapshot.data['robot_weight']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 900),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 850),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot Frame Length",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 950),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getData(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 900),
                                    curve: Curves.easeInOutExpo,
                                    child: Text(
                                        '${snapshot.data['robot_frame_length']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 950),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot Frame Width",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 1050),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getData(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.easeInOutExpo,
                                    child: Text(
                                        '${snapshot.data['robot_frame_width']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 1100),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 1050),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot Drivetrain Type",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 1150),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getData(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 1100),
                                    curve: Curves.easeInOutExpo,
                                    child: Text(
                                        '${snapshot.data['robot_drivetrain_type']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 1200),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 1150),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot Height",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 1250),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getData(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 1200),
                                    curve: Curves.easeInOutExpo,
                                    child: Text(
                                        '${snapshot.data['robot_highlow']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 1300),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 1250),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot Goal",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 1350),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getData(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 1300),
                                    curve: Curves.easeInOutExpo,
                                    child: Text(
                                        '${snapshot.data['robot_goal']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 1400),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 1350),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot CP Rotational Control",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 1450),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getRot(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 1400),
                                    curve: Curves.easeInOutExpo,
                                    child: Text('${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 1450),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot CP Positional Control",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 1550),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getPos(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 1500),
                                    curve: Curves.easeInOutExpo,
                                    child: Text('${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                         Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 1700),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 1650),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot Implements Autonomous",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 1750),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getAuto(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 1700),
                                    curve: Curves.easeInOutExpo,
                                    child: Text('${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 1600),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 1550),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot Vision Type",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 1650),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getData(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 1600),
                                    curve: Curves.easeInOutExpo,
                                    child: Text(
                                        '${snapshot.data['robot_vision_type']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 1800),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 1750),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot Climbs",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 1850),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getClimb(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 1800),
                                    curve: Curves.easeInOutExpo,
                                    child: Text('${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 1900),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 1850),
                            curve: Curves.easeInOutExpo,
                            child: Text("Robot Buddy Climb",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 1950),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getBuddy(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 1900),
                                    curve: Curves.easeInOutExpo,
                                    child: Text('${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 2000),
                        curve: Curves.easeInOutExpo,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 1950),
                            curve: Curves.easeInOutExpo,
                            child: Text("Notes",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold', fontSize: 15))),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 2050),
                          curve: Curves.easeInOutExpo,
                          padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: FutureBuilder<dynamic>(
                            future: getData(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 2000),
                                    curve: Curves.easeInOutExpo,
                                    child: Text('${snapshot.data['notes']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 13)));
                              return Text(" ");
                            },
                          ),
                        )),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
