import 'package:bloc_login/database/user_database.dart';
import 'package:bloc_login/profile/ProfileSettings.dart';
import 'package:bloc_login/profile/team_users.dart';
import 'package:flutter/material.dart';
import 'package:bloc_login/api_connection/profile_conection.dart';
import 'PersonalPitEntries.dart';
import 'dart:async';
import 'settings.dart';

import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController controller;

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
  void initState() {
    super.initState();
    getImageData();
    getFirstName();
    getLastName();
    getTeamRole();
    getPitEntries();
    getMatchEntries();
    getTeamNum();
    getTeamName();
    changeRoleColor();
    getTeamMatchEntries(getTeamNum());
    getTeamPitEntries(getTeamNum());

    _leftPadding = 25;
    _opacity = 0;
    Timer(const Duration(milliseconds: 1000), () {
      _changePadding();
      _changeOpacity();
      _changeSize();
    });

    DatabaseProvider.dbProvider.getToken();
  }

  getProfileID() async {
    var profile = await getProfileData();
    return profile['user'];
  }

  getNameCreds() async {
    var fName = await getFirstName();
    var lName = await getLastName();
    var username = await getUserData();
    if (fName == " ") {
      return username;
    } else {
      return fName + " " + lName;
    }
  }

  getUserRole() async {
    var role = await getTeamRole();
    if (role == "Mentor") {
      return "Mentor";
    } else {
      return "Member";
    }
  }

  getUserRoleWidget() async {
    var role = await getTeamRole();
    if (role == "Mentor") {
      return Text("Team Management");
    } else {
      return null;
    }
  }

  changeRoleColor() async {
    var role = await getTeamRole();
    if (role == "Mentor") {
      return Color.fromRGBO(233, 64, 87, 1);
    } else {
      return Color.fromRGBO(64, 149, 233, 1);
    }
  }

  returnTeamNumber() async {
    var num = await getTeamNum();
    print(num);
    return num;
  }

  double _leftPadding = 0;
  double _opacity = 0;
  double _size = 50;

  _changePadding() {
    if (getNameCreds() != " ") {
      setState(() {
        _leftPadding = 12;
      });
    }
  }

  _changeOpacity() {
    setState(() {
      _opacity = 1;
    });
  }

  _changeSize() {
    setState(() {
      _size = 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).backgroundColor;

    getColor() {
      print(color);
      return color;
    }


    invertShadow() {
      if (getColor() == Colors.black) {
        return Color.fromRGBO(0, 0, 0, .05);
      } else {
        return Color.fromRGBO(255, 255, 255, 0);
      }
    }

    invertBackground() {
      if (getColor() == Colors.black) {
        return Color.fromRGBO(241, 243, 246, 1);
      } else {
        return Color(0xFF202020);
      }
    }

    invertCard() {
      if (getColor() == Colors.black) {
        return Color.fromRGBO(241, 243, 246, 1);
      } else {
        return Color.fromRGBO(40, 40, 40, 1);
      }
    }



    changeTextColor() {
      if (getColor() == Colors.black) {
        return Color.fromRGBO(112, 112, 112, 1);
      } else {
                return Colors.white;

        
      }
    }

    void showAsBottomSheet() async {
      final result = await showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          duration: Duration(milliseconds: 300),
          cornerRadius: 16,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [1.0, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return Container(
              height: 460,
              child: Center(
                child: Material(
                  child: InkWell(
                    onTap: () => Navigator.pop(context, 'This is the result.'),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
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
                          Container(
                              child: Column(
                            children: <Widget>[
                              FutureBuilder<dynamic>(
                                future: getMatchEntries(),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    return Text('${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: 40,
                                            color: Color.fromRGBO(
                                                112, 112, 112, 1)));
                                  return Text('0',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Bold',
                                          fontSize: 40,
                                          color: changeTextColor()));
                                },
                              ),
                              Text("Personal Match Entries",
                                  style: TextStyle(color: changeTextColor()))
                            ],
                          )),
                          Container(
                              child: Column(
                            children: <Widget>[
                              FutureBuilder<dynamic>(
                                future: getPitEntries(),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    return Text('${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: 40,
                                            color: Color.fromRGBO(
                                                112, 112, 112, 1)));
                                  return Text('0',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Bold',
                                          fontSize: 40,
                                          color: changeTextColor()));
                                },
                              ),
                              Text("Personal Pit Entries",
                                  style: TextStyle(color: changeTextColor()))
                            ],
                          )),
                          Container(
                              child: Column(
                            children: <Widget>[
                              FutureBuilder<dynamic>(
                                future: getTeamMatchEntries(810),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    return Text('${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: 40,
                                            color: changeTextColor()));
                                  return Text('0',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Bold',
                                          fontSize: 40,
                                          color: changeTextColor()));
                                },
                              ),
                              Text("Team Match Entries",
                                  style: TextStyle(
                                      color: Color.fromRGBO(112, 112, 112, 1)))
                            ],
                          )),
                          Container(
                              child: Column(
                            children: <Widget>[
                              FutureBuilder<dynamic>(
                                future: getTeamPitEntries(810),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    return Text('${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: 40,
                                            color: changeTextColor()));
                                  return Text('0',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Bold',
                                          fontSize: 40,
                                          color: changeTextColor()));
                                },
                              ),
                              Text("Team Pit Entries",
                                  style: TextStyle(color: changeTextColor()))
                            ],
                          )),
                          Container(
                              child: Column(
                            children: <Widget>[
                              FutureBuilder<dynamic>(
                                future: getGlobalMatchEntries(810),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    return Text('${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: 40,
                                            color: changeTextColor()));
                                  return Text('0',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Bold',
                                          fontSize: 40,
                                          color: changeTextColor()));
                                },
                              ),
                              Text("Global Match Entries",
                                  style: TextStyle(color: changeTextColor()))
                            ],
                          )),
                        ],
                      )),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      });

      print(result); // This is the result.
    }

    void showAsBottomSheet2() async {
      final result = await showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          duration: Duration(milliseconds: 400),
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.3, 0.3],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return Container(
              height: 400,
              child: Material(
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.insert_chart)),
                            FutureBuilder<dynamic>(
                              future: getProfileID(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return GestureDetector(
                                    child: Text(
                                      "Match Entries",
                                      style: TextStyle(
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PersonalPitEntries(
                                              text:
                                                  '${snapshot.data}'.toString(),
                                            ),
                                          ));
                                    },
                                  );
                                return Text("Match Entries",
                                    style: TextStyle(
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 18));
                              },
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Row(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.clear_all)),
                            FutureBuilder<dynamic>(
                              future: getProfileID(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return GestureDetector(
                                    child: Text(
                                      "Pit Entries",
                                      style: TextStyle(
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileSettings(
                                                    text: '${snapshot.data}'
                                                        .toString()),
                                          ));
                                    },
                                  );
                                return Text("Pit Entries",
                                    style: TextStyle(
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 18));
                              },
                            ),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5, top: 70),
                          child: Row(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(Icons.settings),
                            ),
                            FutureBuilder<dynamic>(
                              future: getProfileID(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return GestureDetector(
                                    child: Text(
                                      "Profile Settings",
                                      style: TextStyle(
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileSettings(
                                                    text: '${snapshot.data}'
                                                        .toString()),
                                          ));
                                    },
                                  );
                                return Text("Profile Settings");
                              },
                            ),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5, top: 190),
                          child: Row(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(Icons.settings),
                            ),
                             GestureDetector(
                                    child: Text(
                                      "General Settings",
                                      style: TextStyle(
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Settings(),
                                                    
                                          ));
                                    },
                                  ),
                              
                            
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Row(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.settings)),
                            FutureBuilder<dynamic>(
                              future: getProfileID(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return GestureDetector(
                                    child: Text(
                                      "Account Settings",
                                      style: TextStyle(
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileSettings(
                                                    text: '${snapshot.data}'
                                                        .toString()),
                                          ));
                                    },
                                  );
                                return Text("Account Settings");
                              },
                            ),
                          ]),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 130.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Icon(Icons.supervisor_account),
                                ),
                                FutureBuilder<dynamic>(
                                  future: getProfileID(),
                                  builder: (context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData)
                                      return GestureDetector(
                                        child: Text(
                                          "Team Users",
                                          style: TextStyle(
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 18,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => TeamUsers(
                                                    text: '${snapshot.data}'
                                                        .toString()),
                                              ));
                                        },
                                      );
                                    return Text("Team Users");
                                  },
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 160.0),
                          child: Row(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.close, color: Colors.red),
                            ),
                            GestureDetector(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 18,
                                  color: Colors.red,
                                ),
                              ),
                              onTap: () {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(LoggedOut());
                              },
                            ),
                          ]),
                        ),
                      ],
                    )),
              ),
            );
          },
        );
      });

      print(result); // This is the result.
    }

    return Scaffold(
      backgroundColor: invertBackground(),
      body: SafeArea(
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          header: WaterDropHeader(),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AnimatedPadding(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOutExpo,
                      padding: EdgeInsets.fromLTRB(_leftPadding, 30, 0, 0),
                      child: AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(milliseconds: 550),
                        curve: Curves.easeInOutExpo,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: FutureBuilder<dynamic>(
                            future: getNameCreds(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return AutoSizeText('${snapshot.data}',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 25,
                                        color: changeTextColor()),
                                    maxLines: 1,
                                    maxFontSize: 25);
                              return Text(
                                "Loading",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 25,
                                    color: changeTextColor()),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 12, 0),
                      child: GestureDetector(
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: invertCard(),
                            boxShadow: [
                              BoxShadow(
                                  color: invertShadow(),
                                  offset: Offset(0, 0),
                                  blurRadius: 80)
                            ],
                          ),
                          child: Center(
                            child: Center(
                              child: new SizedBox( child: Icon(Icons.menu)),
                            ),
                          ),
                        ),
                        onTap: () => showAsBottomSheet2(),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: invertShadow(),
                                  offset: Offset(0, -30),
                                  blurRadius: 50)
                            ],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
                            color: invertCard(),
                          ),
                          height: double.infinity,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: ShapeDecoration(
                          shape: BeveledRectangleBorder(),
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: FutureBuilder<dynamic>(
                            future: getImageData(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                return Image.network(
                                  '${snapshot.data}',
                                  height: 100,
                                  width: 100,
                                );
                              return Text(" ");
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Team",
                                  style: TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      fontSize: 30,
                                      color: changeTextColor()),
                                ),
                                FutureBuilder<dynamic>(
                                  future: getTeamNum(),
                                  builder: (context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData)
                                      return Text(
                                        ' ${snapshot.data}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 30,
                                            color: changeTextColor()),
                                      );
                                    return Text(" Loading",
                                        style: TextStyle(
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 30,
                                            color: changeTextColor()));
                                  },
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: FutureBuilder<dynamic>(
                                future: getTeamName(),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    return Text(
                                      ' ${snapshot.data}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: 15,
                                          color: changeTextColor()),
                                    );
                                  return Text("Loading");
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FutureBuilder<dynamic>(
                              future: changeRoleColor(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    width: 110,
                                    decoration: BoxDecoration(
                                        color: snapshot.data,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    alignment: Alignment.center,
                                    child: FutureBuilder<dynamic>(
                                      future: getUserRole(),
                                      builder: (context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasData)
                                          return Text(
                                            ' ${snapshot.data}',
                                            style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                fontSize: 20,
                                                color: Colors.white),
                                          );
                                        return Text("Loading");
                                      },
                                    ),
                                  );
                                }

                                return Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: snapshot.data,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  alignment: Alignment.center,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Container(
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: Color.fromRGBO(233, 64, 87, 1),
                                ),
                                child: GestureDetector(
                                  child: Center(
                                    child: Text(
                                      "View Entry Data",
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Bold',
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: () => showAsBottomSheet(),
                                )),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
