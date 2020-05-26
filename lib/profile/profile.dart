import 'package:bloc_login/database/user_database.dart';
import 'package:flutter/material.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/api_connection/profile_conection.dart';
import 'package:bloc_login/Constants.dart';
import 'team_users.dart';

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

    DatabaseProvider.dbProvider.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 244, 251, 1),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(12, 30, 0, 0),
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
                        child: Icon(Icons.arrow_back),
                      ),
                    )),
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
                      child: Center(
                        child: Icon(Icons.menu),
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: FutureBuilder<dynamic>(
                    future: getFirstName(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) if (snapshot.data != "") {
                        return Text(
                          '${snapshot.data}',
                          style: TextStyle(
                              fontFamily: 'Poppins-Bold', fontSize: 25),
                        );
                      } else {
                        return Text("Input Your Name In Profile Settings");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                Center(
                  child: FutureBuilder<dynamic>(
                    future: getLastName(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData)
                        return Text(
                          ' ${snapshot.data}',
                          style: TextStyle(
                              fontFamily: 'Poppins-Bold', fontSize: 25),
                        );
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      height: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            
                            children: <Widget>[
                              Text("Team", style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                          fontSize: 25
                              ),),
                              FutureBuilder<dynamic>(
                                future: getTeamNum(),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    return Text(
                                      ' ${snapshot.data}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-SemiBold',
                                          fontSize: 25),
                                    );
                                  return null;
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
                                          fontSize: 15),
                                    );
                                  return null;
                                },
                              ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
