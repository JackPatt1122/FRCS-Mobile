import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:sliding_sheet/sliding_sheet.dart';

class MatchDetail extends StatelessWidget {
  final String text;
  

  MatchDetail({Key key, @required this.text}) : super(key: key);

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/match/" + text),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body));
  }

  Future getInitLineData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/match/" + text),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body)['initiation_line']);
  }


  Future getInitLine() async {
    var data = await getInitLineData();
    if (data == "0") {
      return "No";
    }
    if (data == "100") {
      return "Yes";
    }
  }



  Future getTeamData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://www.thebluealliance.com/api/v3/team/frc" + text),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    return Future.value(json.decode(response.body));
  }

    Future getCompData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://www.thebluealliance.com/api/v3/team/frc" + text + "/events/2020"),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    return Future.value(json.decode(response.body));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      backgroundColor: Colors.grey.shade200,
      body: SlidingSheet(
        closeOnBackdropTap: true,
        elevation: 8,
        cornerRadius: 30,
        snapSpec: const SnapSpec(
          snap: true,
          // Set custom snapping points.
          snappings: [0.05, 0.4, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        body: Container(
            child: ListView(
          children: [
            Align(alignment: Alignment.topLeft,
            
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {  Navigator.pop(context);},
            ),),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: FutureBuilder<dynamic>(
                future: getTeamData(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData)
                    return Text('${snapshot.data['nickname']}',
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold', fontSize: 20));
                  return Text("Loading");
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Text(
                "Team " + text, style: TextStyle(fontSize: 18),
              )
            ),
            SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                    child: Text("Competition",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold', fontSize: 15)),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                      child: FutureBuilder<dynamic>(
                        future: getData(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['competition']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
                        },
                      ),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                    child: Text("Robot Weight",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold', fontSize: 15)),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                      child: FutureBuilder<dynamic>(
                        future: getData(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['robot_weight']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
                        },
                      ),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                    child: Text("Robot Frame Length",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold', fontSize: 15)),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                      child: FutureBuilder<dynamic>(
                        future: getData(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text(
                                '${snapshot.data['robot_frame_length']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
                        },
                      ),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                    child: Text("Robot Frame Width",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold', fontSize: 15)),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                      child: FutureBuilder<dynamic>(
                        future: getData(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['robot_frame_width']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
                        },
                      ),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                    child: Text("Robot Drivetrain Type",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold', fontSize: 15)),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                      child: FutureBuilder<dynamic>(
                        future: getData(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text(
                                '${snapshot.data['robot_drivetrain_type']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
                        },
                      ),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                    child: Text("Robot Height",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold', fontSize: 15)),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                      child: FutureBuilder<dynamic>(
                        future: getData(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['robot_highlow']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
                        },
                      ),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                    child: Text("Robot Goal",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold', fontSize: 15)),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                      child: FutureBuilder<dynamic>(
                        future: getData(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['robot_goal']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
                        },
                      ),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                    child: Text("Robot CP Rotational Control",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold', fontSize: 15)),
                  ),
                ),

                SizedBox(
                  height: 70,
                ),
              ],
            )),
          ],
        )),
        builder: (context, state) {
          return Container(
            height: 500,
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
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                          child: Text("Team Information")),
                    ),
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
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['nickname']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
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
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['state_prov']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
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
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['city']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
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
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['school_name']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
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
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['rookie_year']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
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
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data[0]['name']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
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
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data['home_championship']['2020']}',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 13));
                          return Text("Loading");
                        },
                      ),
                    )),
                  ],
                )),
          );
        },
      ),
    );
  }
}
