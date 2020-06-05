import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'pit_model.dart';
import 'package:bloc_login/scout/Pit.dart';

import 'package:bloc_login/api_connection/profile_conection.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PitList extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State {
  List data;
  String selectedItem;
  double _leftPadding = 20;
  double _opacity = 0;

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

    print(data);

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
    this.getData();
    _leftPadding = 20;
    Timer(const Duration(milliseconds: 500), () {
      _changePadding();
      _changeOpacity();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(241, 244, 251, 1),
        body: SmartRefresher(
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
                              color: Color.fromRGBO(102, 102, 102, 1))),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 5, right: 50),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Colors.white,
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
                        controller: myController,
                        decoration: InputDecoration(
                            labelText: 'Team Number',
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(193, 193, 193, 1))),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 70, 5, 0),
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: Color.fromRGBO(237, 84, 65, 1)),
                        child: GestureDetector(
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() {
                              var teamNum = myController.text;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ListDetail(text: teamNum)));
                            });
                          },
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: AnimationLimiter(
                    child: ListView.builder(
                      
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        
                        return AnimationConfiguration.staggeredList(
                          
                            position: index,
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 75,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0x29000000),
                                            offset: Offset(0, 0),
                                            blurRadius: 40)
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          selected: data[index] == selectedItem,
                                          title: AnimatedPadding(
                                            padding: EdgeInsets.only(
                                                left: _leftPadding),
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeInOutExpo,
                                            child: AnimatedOpacity(
                                              opacity: _opacity,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              curve: Curves.easeInOutExpo,
                                              child: Text(
                                                data[index]['team_num']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Poppins-Bold',
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          subtitle: FutureBuilder<dynamic>(
                                            future: getTeamNameList(data[index]
                                                    ['team_num']
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
                                                  curve: Curves.easeInOutExpo,
                                                  child: AnimatedOpacity(
                                                      opacity: _opacity,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve:
                                                          Curves.easeInOutExpo,
                                                      child: Text(
                                                          ' ${snapshot.data}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins-Medium',
                                                              fontSize: 15))),
                                                );
                                              return AnimatedPadding(
                                                  padding: EdgeInsets.only(
                                                      left: _leftPadding),
                                                  duration: Duration(
                                                      milliseconds: 600),
                                                  curve: Curves.easeInOutExpo,
                                                  child: AnimatedOpacity(
                                                      opacity: _opacity,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve:
                                                          Curves.easeInOutExpo,
                                                      child: Text("Loading")));
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
                            ));
                      },
                    ),
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
                                        text: '${snapshot.data}'.toString())));
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
                      return Text("New Entry");
                    },
                  ),
                )
              ],
            )));
  }
}
