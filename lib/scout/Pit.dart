import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:random_string/random_string.dart';
import 'pitdone.dart';
import 'package:bloc_login/dao/user_dao.dart';
import 'package:bloc_login/api_connection/profile_conection.dart';
import 'package:bloc_login/profile/profile.dart';

class PitScout extends StatefulWidget {
  @override
  _PitScoutState createState() => _PitScoutState();

  final String text;

  PitScout({Key key, @required this.text}) : super(key: key);
}

class _PitScoutState extends State<PitScout> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    getTeamName(teamNumController.text);

    setState(() {});
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  String teamName;

  List data = List(); //edited line

  Future getCompsList() async {
    var response = await http.get(
        Uri.encodeFull("https://www.thebluealliance.com/api/v3/team/frc" +
            widget.text +
            '/events/2020'),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    setState(() {
      data = json.decode(response.body);
    });

    return Future.value(json.decode(response.body));
  }


  
  getTeamName(num) async {
    var response = await http.get(
        Uri.encodeFull("https://www.thebluealliance.com/api/v3/team/frc" + num),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    setState(() {
      if (json.decode(response.body)['nickname'] == null) {
        teamName = "No Team Entered";
      } else {
        teamName = json.decode(response.body)['nickname'];
      }
    });

    return Future.value(json.decode(response.body)['nickname']);
  }

  createStatID() {
    var number = randomNumeric(15);
    return number;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    teamNumController.dispose();
    super.dispose();
  }

    double _leftPadding = 25;
  double _opacity = 0;
  double  _containerHeight = 0;

  _changePadding() {
    setState(() {
      _leftPadding = 12;
    });
  }

  _changeOpacity() {
    setState(() {
      _opacity = 1;
    });
  }

   _changeHeight() {
    setState(() {
      _containerHeight = 140;
    });
  }

  getProfile() async {
    var token = await UserDao().getToken(0);
    var user = await getUserData();
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + user),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });


    return Future.value(json.decode(response.body)['profile']);
  }




  getProfileID() async {
    var profile = await getProfile();
    print(profile['user']);
    return profile['user'];
  }

  getID(data){
    return data;
  }
  


  final teamNumController = TextEditingController();
  final weightController = TextEditingController();
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  final notesController = TextEditingController();
  String _comp;
  String _dtType;
  String _height;
  String _goal;
  String _vision;
  String _auto;
  String _climb;
  String _buddy;
  String _rot;
  String _pos;
  String _new;



  submitData() {
     http.post(
      

        Uri.encodeFull("http://192.168.86.37:8000/api/pitcreation/"),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6',
          
        },
        body: {
          "team_num": teamNumController.text.toString(),
          "competition": _comp,
          "scout": getProfileID().toString(),
          "scouted_team_num": widget.text.toString(),
          "robot_weight": weightController.text,
          "robot_frame_length": lengthController.text.toString(),
          "robot_frame_width": widthController.text.toString(),
          "robot_drivetrain_type": _dtType.toString(),
          "robot_vision_type": _vision.toString(),
          "robot_vision_implement": "No".toString(),
          "robot_goal": _goal.toString(),
          "robot_autonomous": _auto.toString(),
          "robot_highlow": _height.toString(),
          "robot_climb": _climb.toString(),
          "robot_buddy_climb": _buddy.toString(),
          "robot_control_panel_rot": _rot.toString(),
          "robot_control_panel_pos": _pos.toString(),
          "is_new_robot": _new.toString(),
          "notes": notesController.text,
          "stat_id": createStatID().toString(),
          


        }
        );

  }

  @override
  void initState() {
    super.initState();
    this.getCompsList();
    teamName = "No Team Entered";
     _leftPadding = 25;
    _opacity = 0;
    Timer(const Duration(milliseconds: 0), () {
          _changeHeight();


    });

    Timer(const Duration(milliseconds: 500), () {
      _changePadding();
      _changeOpacity();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: WaterDropHeader(),
        child: ListView(
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.topLeft,
                child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutExpo,
              height: _containerHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 89, 89, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromRGBO(0, 0, 0, .5),
                            offset: Offset(0, 0),
                            blurRadius: 20)
                      ],
                    ),
                    child: Stack(
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
                            onTap: () => Navigator.of(context).pop(),
                          ),
                        ),
                        Container(
                          child: AnimatedPadding(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutExpo,
                              padding: EdgeInsets.only(left: _leftPadding, top: 60),
                              child: Text(
                                "New Pit Entry",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Poppins-Bold',
                                    color: Colors.white),
                              )),
                        ),
                        Container(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 12, top: 95, bottom: 15),
                              child: Text(
                                teamName.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        ),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
              child: TextFormField(
                style: TextStyle(fontFamily: 'Poppins-Bold', fontSize: 25),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                controller: teamNumController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Team',
                ),
              ),
            ),
            Center(
                child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 20),
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      disabledHint: Text(
                        "Team Competition",
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      items: data.map((item) {
                        return new DropdownMenuItem(
                          child: Center(
                            child: new Text(
                              item['name'].toString().replaceAll(
                                    '***SUSPENDED***',
                                    ' ',
                                  ),
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          value: item['name'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _comp = newVal;
                          getProfileID();
                        });
                      },
                      value: _comp,
                      hint: Text("Team Competition",
                          style: TextStyle(
                              fontFamily: 'Poppins-Bold', fontSize: 25),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
                Center(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: TextFormField(
                        style:
                            TextStyle(fontFamily: 'Poppins-Bold', fontSize: 25),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: weightController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Robot Weight',
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: TextFormField(
                        style:
                            TextStyle(fontFamily: 'Poppins-Bold', fontSize: 25),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: lengthController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Robot Frame Length',
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: TextFormField(
                        style:
                            TextStyle(fontFamily: 'Poppins-Bold', fontSize: 25),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: widthController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Robot Frame Width',
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: _height,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _height = newValue;
                            });
                          },
                          items: <String>['Low - Below 28"', 'High - Above 28"']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("Robot Height",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: _dtType,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _dtType = newValue;
                            });
                          },
                          items: <String>[
                            '4 Wheel Drivetrain',
                            '6 Wheel Drivetrain',
                            '8 Wheel Drivetrain',
                            'Treads',
                            'Omni',
                            'Swerve',
                            'Other'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("Robot DriveTrain",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: _goal,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _goal = newValue;
                            });
                          },
                          items: <String>[
                            'Low Goal',
                            'High Goal',
                            'Both Low and High',
                            'None'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("Robot Goal",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: _auto,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _auto = newValue;
                            });
                          },
                          items: <String>[
                            'Yes',
                            'No',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("Robot Autonomous",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: _climb,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _climb = newValue;
                            });
                          },
                          items: <String>[
                            'Yes',
                            'No',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("Robot Climb",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: _vision,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _vision = newValue;
                            });
                          },
                          items: <String>[
                            'None',
                            'Limelight',
                            'Raspberry Pi',
                            'Other'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("Robot Vision Type",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: _buddy,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _buddy = newValue;
                            });
                          },
                          items: <String>[
                            'Yes',
                            'No',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("Robot Buddy Climb",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: _pos,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _pos = newValue;
                            });
                          },
                          items: <String>[
                            'Yes',
                            'No',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("CP Position Control",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: _rot,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _rot = newValue;
                            });
                          },
                          items: <String>[
                            'Yes',
                            'No',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("CP Rotation Control",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: _new,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _new = newValue;
                            });
                          },
                          items: <String>[
                            'Yes',
                            'No',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("New Robot",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: TextFormField(
                        style:
                            TextStyle(fontFamily: 'Poppins-Bold', fontSize: 15),
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        textAlign: TextAlign.center,
                        controller: notesController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Notes',
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 12, right: 12), child:  Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Color.fromRGBO(233, 64, 87, 1),
                              ),
                              child: GestureDetector(
                                child: Center(
                                  child: Text(
                                    "Submit Data",
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ),
                                onTap: () { submitData();  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PitDone()
                                          ));
                            }),
                              )),
                        )),
                    
                   
                  ],
                )),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
