import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'CompetitionsDetail.dart';

class CompetitionsList extends StatefulWidget {
  @override
  CompetitionsListState createState() => new CompetitionsListState();
}

class CompetitionsListState extends State {
  List data;
  String selectedItem;
  double _leftPadding = 20;
  double _opacity = 0;
  String _teamNumSelected;

  double _CancelOpacity = 0;
  double _searchPadding = 7;
  double _CancelPadding = 7;

  final myController = TextEditingController();

  TextEditingController controller = new TextEditingController();



  Future getPersonalCompsList() async {
    var response = await http.get(
        Uri.encodeFull("https://www.thebluealliance.com/api/v3/team/frc810/events/2020"),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
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

  @override
  void initState() {
    this.getPersonalCompsList();
    _leftPadding = 20;
    _searchPadding = 7;
    _CancelPadding = 0;
    _CancelOpacity = 0;
    Timer(const Duration(milliseconds: 500), () {
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
                          child: Text("Competitions",
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
                          padding: const EdgeInsets.fromLTRB(12, 120, 0, 0),
                          child: Text("My Competitions",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Poppins-Bold',
                                  color: iconColor())),
                        ),
                    Padding(
                      padding: const EdgeInsets.only(top: 150),
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
                                          onLongPress: () {},
                                          child: Column(
                                            children: <Widget>[
                                              ListTile(
                                                selected:
                                                    data[index]['event_code'] == selectedItem,
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
                                                      data[index]['name']
                                                          .toString().replaceAll('***SUSPENDED***', ''),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins-Bold',
                                                          fontSize: 15,
                                                          color: invertColor()),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    selectedItem = data[index]
                                                            ['event_code']
                                                        .toString();
                                                    Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .rightToLeft,
                                                          curve: Curves
                                                              .easeInOutExpo,
                                                          child: CompetitionsDetail(text: selectedItem)),
                                                    );
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
                    
                    
                  ],
                ))));
  }
}
