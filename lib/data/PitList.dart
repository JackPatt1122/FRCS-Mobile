import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'pit_model.dart';
import 'package:bloc_login/scout/Pit.dart';

import 'package:bloc_login/api_connection/profile_conection.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/services.dart';

class PitList extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State {
  List data;
  String selectedItem;
  double _leftPadding = 20;
  double _opacity = 0;
  String _teamNumSelected;

  double _CancelOpacity = 0;
  double _searchOpacity;
  double _searchPadding = 7;
  double _CancelPadding = 7;

  final myController = TextEditingController();

  TextEditingController controller = new TextEditingController();

  Future getData() async {
    var response = await http
        .get(Uri.encodeFull("http://192.168.86.37:8000/api/pit"), headers: {
      "Accept": "application/json",
      'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
    });

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  Future getStatsData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://192.168.86.37:8000/api/pit/" + _teamNumSelected.toString()),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body));
  }

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

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Quick Data"),
            content: new Column(
              children: <Widget>[
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
                  child: FutureBuilder<dynamic>(
                    future: getData(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
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
                )
              ],
            ),
            actions: <Widget>[
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

  @override
  void initState() {
    this.getData();
    _leftPadding = 20;
    _searchPadding = 7;
    _CancelPadding = 0;
    _CancelOpacity = 0;
    Timer(const Duration(milliseconds: 1000), () {
      _changePadding();
      _changeOpacity();
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
    myController.dispose();
    super.dispose();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    setState(() {});
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) setState(() {});
    _refreshController.loadComplete();
    setState(() {});
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
      } else {
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

    return Scaffold(
        body: SafeArea(
            child: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                header: WaterDropHeader(),
                child: new Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 30, 0, 0),
                          child: Text("Pit Entries",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Poppins-Bold',
                                  color: iconColor())),
                        ),
                      ],
                    ),
                    AnimatedPadding(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOutExpo,
                      padding: EdgeInsets.only(
                          top: 70, left: 5, right: _searchPadding),
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
                            controller: myController,
                            decoration: InputDecoration(
                                labelText: 'Team Number',
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(193, 193, 193, 1))),
                            onTap: () => setState(() {
                              _searchPadding = 70;
                              _CancelOpacity = 1;
                              _CancelPadding = 10;
                            }),
                            onEditingComplete: () => setState(() {
                              _searchPadding = 7;
                              _CancelOpacity = 0;
                              _CancelPadding = 0;
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
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
                        padding: EdgeInsets.fromLTRB(0, 80, _CancelPadding, 0),
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
                      padding: const EdgeInsets.only(top: 120),
                      child: ListView.builder(
                        itemCount: data == null ? 0 : data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        child: GestureDetector(
                                          onLongPress: () {
                                            _showDialog();
                                            setState(() {
                                              _teamNumSelected =
                                                  data[index]['team_num'];
                                            });
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              ListTile(
                                                selected:
                                                    data[index] == selectedItem,
                                                title: AnimatedPadding(
                                                  padding: EdgeInsets.only(
                                                      left: _leftPadding),
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOutExpo,
                                                  child: AnimatedOpacity(
                                                    opacity: _opacity,
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                    curve: Curves.easeInOutExpo,
                                                    child: Text(
                                                      data[index]['team_num']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins-Bold',
                                                          fontSize: 20,
                                                          color: invertColor()),
                                                    ),
                                                  ),
                                                ),
                                                subtitle:
                                                    FutureBuilder<dynamic>(
                                                  future: getTeamNameList(
                                                      data[index]['team_num']
                                                          .toString()),
                                                  builder: (context,
                                                      AsyncSnapshot<dynamic>
                                                          snapshot) {
                                                    if (snapshot.hasData)
                                                      return AnimatedPadding(
                                                        padding: EdgeInsets.only(
                                                            left: _leftPadding),
                                                        duration: Duration(
                                                            milliseconds: 600),
                                                        curve: Curves
                                                            .easeInOutExpo,
                                                        child: AnimatedOpacity(
                                                            opacity: _opacity,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    500),
                                                            curve: Curves
                                                                .easeInOutExpo,
                                                            child: Text(
                                                                ' ${snapshot.data}',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins-Medium',
                                                                    fontSize:
                                                                        15,
                                                                    color:
                                                                        invertColor()))),
                                                      );
                                                    return AnimatedPadding(
                                                        padding: EdgeInsets.only(
                                                            left: _leftPadding),
                                                        duration: Duration(
                                                            milliseconds: 600),
                                                        curve: Curves
                                                            .easeInOutExpo,
                                                        child: AnimatedOpacity(
                                                            opacity: _opacity,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    500),
                                                            curve: Curves
                                                                .easeInOutExpo,
                                                            child: Text(
                                                              "Loading",
                                                              style: TextStyle(
                                                                  color:
                                                                      invertColor()),
                                                            )));
                                                  },
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    selectedItem = data[index]
                                                            ['team_num']
                                                        .toString();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ListDetail(
                                                            text: selectedItem,
                                                          ),
                                                        ));
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )));
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: FutureBuilder<dynamic>(
                        future: getTeamNum(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PitScout(
                                            text: '${snapshot.data}'
                                                .toString())));
                              },
                              child: Container(
                                  width: 110,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    gradient: LinearGradient(
                                        begin: Alignment(-1.0, -0.5),
                                        end: Alignment(1.5, 0.5),
                                        colors: [
                                          Color.fromRGBO(242, 113, 33, 1),
                                          Color.fromRGBO(233, 64, 87, 1),
                                          Color.fromRGBO(138, 35, 135, 1),
                                        ]),
                                  ),
                                  child: Center(
                                    child: Text("New Entry",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Poppins-Bold',
                                            color: Colors.white)),
                                  )),
                            );
                          return Container(
                              width: 110,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                gradient: LinearGradient(
                                    begin: Alignment(-1.0, -0.5),
                                    end: Alignment(1.5, 0.5),
                                    colors: [
                                      Color.fromRGBO(242, 113, 33, 1),
                                      Color.fromRGBO(233, 64, 87, 1),
                                      Color.fromRGBO(138, 35, 135, 1),
                                    ]),
                              ),
                              child: Center(
                                child: Text("New Entry",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Poppins-Bold',
                                        color: Colors.white)),
                              ));
                        },
                      ),
                    )
                  ],
                ))));
  }
}
