import 'package:bloc_login/database/user_database.dart';
import 'package:flutter/material.dart';
import 'package:bloc_login/api_connection/profile_conection.dart';

import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:bloc_login/Constants.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController controller;

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

    DatabaseProvider.dbProvider.getToken();
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

  changeRoleColor() async {
    var role = await getTeamRole();
    if (role == "Mentor") {
      return Color.fromRGBO(233, 64, 87, 1);
    } else {
      return Color.fromRGBO(64, 149, 233, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    var roleColor = changeRoleColor();
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
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("TEST"),
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
            );
          },
        );
      });

      print(result); // This is the result.
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 243, 246, 1),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 12, 0),
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
                      child: Container(
                        child: Center(
                          child: PopupMenuButton<String>(
                            icon: Icon(Icons.menu),
                            onSelected: choiceAction,
                            itemBuilder: (BuildContext context) {
                              return Constants.choices.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            FutureBuilder<dynamic>(
              future: getNameCreds(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData)
                  return Text(
                    ' ${snapshot.data}',
                    style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 25,
                        color: Color.fromRGBO(102, 102, 102, 1)),
                  );
                return Text("Loading");
              },
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100 / 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromRGBO(0, 0, 0, .18),
                              offset: Offset(0, 30),
                              blurRadius: 90)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: Color.fromRGBO(241, 243, 246, 1),
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
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            return Image.network(
                              '${snapshot.data}',
                              height: 100,
                              width: 100,
                            );
                          return Text("Loading");
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
                                  color: Color.fromRGBO(102, 102, 102, 1)),
                            ),
                            FutureBuilder<dynamic>(
                              future: getTeamNum(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return Text(
                                    ' ${snapshot.data}',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 30,
                                        color:
                                            Color.fromRGBO(102, 102, 102, 1)),
                                  );
                                return Text("Loading");
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
                                      color: Color.fromRGBO(102, 102, 102, 1)),
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
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
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

                            return null;
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
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      print('Settings');
    } else if (choice == Constants.stats) {
      print('Subscribe');
    } else if (choice == Constants.members) {
      print('SignOut');
    } else if (choice == Constants.SignOut) {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    }
  }
}
