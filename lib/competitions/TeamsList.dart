import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class CompetitionTeamList extends StatefulWidget {
  @override
  _CompetitionTeamListState createState() => _CompetitionTeamListState();

  String text;

  CompetitionTeamList({Key key, @required this.text}) : super(key: key);
}

class _CompetitionTeamListState extends State<CompetitionTeamList> {
  List data;

  String selectedItem;

  String filter;

  double _leftPadding = 20;
  double _opacity = 0;
  String _teamNumSelected;

  double _CancelOpacity = 1;
  double _searchOpacity;
  double _searchPadding = 7;
  double _CancelPadding = 7;

  TextEditingController controller = new TextEditingController();

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
    });

    return "Success!";
  }

  @override
  initState() {
    super.initState();
    getData();
    _leftPadding = 20;
    _searchPadding = 7;
    _CancelOpacity = 1;
    _CancelPadding = 0;

    Timer(const Duration(milliseconds: 1000), () {
      _changePadding();
      _changeOpacity();
    });
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  CancelSearchState() {
    setState(() {
      _searchPadding = 7;
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      FocusScope.of(context).unfocus();
      controller.clear();
      _CancelOpacity = 0;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).backgroundColor;

    getColor() {
      return color;
    }

    invertBackground() {
      if (getColor() == Colors.black) {
        return Color(0xFF202020);
      } else {
        return Color.fromRGBO(241, 243, 246, 1);
      }
    }

    iconColor() {
      if (getColor() == Colors.black) {
        return Colors.black;
      } if (getColor() == Colors.white) {
        return Colors.white;
      }
    }

    invertColor() {
      if (getColor() == Colors.black) {
        return Colors.black;
      } else {
        return Colors.white;
      }
    }

    return Material(
        child: Scaffold(
            body: SafeArea(
                child: Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 12),
          child: Text('Participating Teams',
              style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold')),
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
                    color: iconColor(),
                  ),
                ),
              ),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        AnimatedPadding(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOutExpo,
          padding: EdgeInsets.only(top: 85, left: 5, right: _searchPadding),
          child: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: invertBackground(),
              border: Border.all(style: BorderStyle.none),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 0),
                    blurRadius: 40)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 7, right: 7),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: controller,
                decoration: InputDecoration(
                    labelText: 'Team Number',
                    border: InputBorder.none,
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(193, 193, 193, 1))),
                onTap: () => setState(() {
                  _searchPadding = 70;
                  _CancelOpacity = 1;
                  _CancelPadding = 10;
                }),
                onEditingComplete: () => setState(() {
                  _searchPadding = 7;
                  _CancelOpacity = 0;
                  _CancelPadding = 0;
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  FocusScope.of(context).unfocus();
                  controller.clear();
                }),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: AnimatedPadding(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutExpo,
            padding: EdgeInsets.fromLTRB(0, 95, _CancelPadding, 0),
            child: AnimatedOpacity(
                opacity: _CancelOpacity,
                duration: Duration(milliseconds: 500),
                child: GestureDetector(
                  onTap: CancelSearchState,
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Color(0xFFF1F3F6)),
                  ),
                )),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 130),
            child: ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  return filter == null || filter == ""
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            child: GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    selected: data[index] == selectedItem,
                                    title: Padding(
                                      padding:
                                          EdgeInsets.only(left: _leftPadding),
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
                                      builder: (context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasData)
                                          return AnimatedPadding(
                                            padding: EdgeInsets.only(
                                                left: _leftPadding),
                                            duration:
                                                Duration(milliseconds: 600),
                                            curve: Curves.easeInOutExpo,
                                            child: AnimatedOpacity(
                                                opacity: _opacity,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.easeInOutExpo,
                                                child: Text(' ${snapshot.data}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Poppins-Medium',
                                                        fontSize: 15,
                                                        color: Colors.black))),
                                          );
                                        return AnimatedPadding(
                                            padding: EdgeInsets.only(
                                                left: _leftPadding),
                                            duration:
                                                Duration(milliseconds: 600),
                                            curve: Curves.easeInOutExpo,
                                            child: AnimatedOpacity(
                                              opacity: _opacity,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.easeInOutExpo,
                                              child: Text("Loading",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : data[index]['key']
                              .toString()
                              .replaceAll('frc', '')
                              .contains(filter)
                          ? new Padding(
                          padding:  EdgeInsets.all(5.0), child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: new Text("Team " +
                                data[index]['key']
                                    .toString()
                                    .replaceAll('frc', ''),
                            style: TextStyle(
                                              fontFamily: 'Poppins-Bold',
                                              fontSize: 20,
                                              color: Colors.black),),
                                              
                              )))
                          : new Container();
                }))
      ],
    ))));
  }
}
