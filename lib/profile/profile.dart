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
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.8),
        offset: Offset(-6.0, -6.0),
        blurRadius: 16.0,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        offset: Offset(6.0, 6.0),
        blurRadius: 16.0,
      ),
    ],),
          height: 300,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12, 40, 0, 0),
                  child: Text("My Profile",
                      style: TextStyle(
                          fontFamily: 'Poppins-Medium', fontSize: 20)),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(162, 40, 0, 0),
                  child:  PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
                ),
              ),
                ],
              ),
              
              Center(
                child: FutureBuilder<dynamic>(
                  future: getImageData(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData)
                      return Image.network(
                        '${snapshot.data}',
                        height: 80,
                        width: 80,
                        fit: BoxFit.fitWidth,
                      );
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: FutureBuilder<dynamic>(
                      future: getFirstName(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData)
                        if(snapshot.data != ""){
                          return Text(
                            '${snapshot.data}',
                            style: TextStyle(
                                fontFamily: 'Poppins-Bold', fontSize: 15),
                          );
                        }
                        else{
                          return Text("Username");
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
                                fontFamily: 'Poppins-Bold', fontSize: 15),
                          );
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              ),
              Center(
                child: FutureBuilder<dynamic>(
                  future: getTeamName(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData)
                      return Text(
                        ' ${snapshot.data}',
                        style: TextStyle(
                            fontFamily: 'Poppins-Light', fontSize: 13),
                      );
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              Center(
                child: FutureBuilder<dynamic>(
                  future: getTeamRole(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData)
                      return Text(
                        ' ${snapshot.data}',
                        style: TextStyle(
                            fontFamily: 'Poppins-Light', fontSize: 13),
                      );
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        FutureBuilder<dynamic>(
                          future: getMatchEntries(),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData)
                              return Text('${snapshot.data}',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 20));
                            return const CircularProgressIndicator();
                          },
                        ),
                        Text('Match Entries',
                            style: TextStyle(
                                fontFamily: 'Poppins-Light', fontSize: 13))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        FutureBuilder<dynamic>(
                          future: getPitEntries(),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData)
                              return Text('${snapshot.data}',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 20));
                            return const CircularProgressIndicator();
                          },
                        ),
                        Text('Pit Entries',
                            style: TextStyle(
                                fontFamily: 'Poppins-Light', fontSize: 13))
                      ],
                    ),
                  ),
                ],
              ), 
              
            ],
            
          ),
        ),
      ),
    );
  }
  void choiceAction(String choice){
    if(choice == Constants.Settings){
      print('Settings');
    }else if(choice == Constants.stats){
      print('Subscribe');
    }else if(choice == Constants.members){
      Navigator.push(context, MaterialPageRoute(builder: (context) => TeamUsers()));
    
    }else if(choice == Constants.SignOut){
      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
    }
}
}

