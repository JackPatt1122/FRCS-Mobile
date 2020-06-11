import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CompetitionTeamList extends StatefulWidget {
  @override
  _CompetitionTeamListState createState() => _CompetitionTeamListState();

  String text;

  CompetitionTeamList({Key key, @required this.text}) : super(key: key);
}

class _CompetitionTeamListState extends State<CompetitionTeamList> {
  List data;
  String selectedItem;

  Future getTeamNameList(data) async {
    var response = await http.get(
        Uri.encodeFull("https://www.thebluealliance.com/api/v3/team/" + data),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    return Future.value(json.decode(response.body)['nickname']);
  }

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://www.thebluealliance.com/api/v3/event/2020nyli2/teams"),
        headers: {
          "Accept": "application/json",
          'X-TBA-Auth-Key':
              'PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw'
        });

    this.setState(() {
      data = json.decode(response.body);
      print(json.decode(response.body));
    });

    return "Success!";
  }

  double _leftPadding = 20;
  double _opacity = 1;

  _changePadding() {
    setState(() {
      _leftPadding = 0;
    });
  }

  _changeOpacity() {
    setState(() {
      _opacity = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _leftPadding = 20;
    _opacity = 1;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            body:  SafeArea(child: Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 12),
          child: Text('Participating Teams', style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold')),
        ),
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
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 120),
            child: ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: GestureDetector(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              selected: data[index] == selectedItem,
                              title: Padding(
                                padding: EdgeInsets.only(left: _leftPadding),
                                child: Text(
                                  "Team " +
                                      data[index]['key']
                                          .toString()
                                          .replaceAll('frc', ''),
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              ),
                              subtitle: FutureBuilder<dynamic>(
                                future: getTeamNameList(
                                    data[index]['key'].toString()),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    return AnimatedPadding(
                                      padding:
                                          EdgeInsets.only(left: _leftPadding),
                                      duration: Duration(milliseconds: 600),
                                      curve: Curves.easeInOutExpo,
                                      child: AnimatedOpacity(
                                          opacity: _opacity,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOutExpo,
                                          child: Text(' ${snapshot.data}',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins-Medium',
                                                  fontSize: 15,
                                                  color: Colors.black))),
                                    );
                                  return AnimatedPadding(
                                      padding:
                                          EdgeInsets.only(left: _leftPadding),
                                      duration: Duration(milliseconds: 600),
                                      curve: Curves.easeInOutExpo,
                                      child: AnimatedOpacity(
                                        opacity: _opacity,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOutExpo,
                                        child: Text("Loading",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ],
    ))));
  }
}
