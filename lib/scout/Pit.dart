import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

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

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    teamNumController.dispose();
    super.dispose();
  }

  final teamNumController = TextEditingController();
  final weightController = TextEditingController();
  String _comp;
  String _dtType;
  String _height;

  @override
  void initState() {
    super.initState();
    this.getCompsList();
    teamName = "No Team Entered";
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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),
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
                    child: Padding(
                        padding: EdgeInsets.only(left: 12, top: 50),
                        child: Text(
                          "New Pit Entry",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Poppins-Bold',
                              color: Color.fromRGBO(102, 102, 102, 1)),
                        )),
                  ),
                  Container(
                    child: Padding(
                        padding: EdgeInsets.only(left: 12, top: 85),
                        child: Text(
                          teamName.toString(),
                          style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontSize: 18),
                        )),
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
              child: TextFormField(
                style: TextStyle(fontFamily: 'Poppins-Bold', fontSize: 30),
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
                        "Competition",
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: 30,
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
                        });
                      },
                      value: _comp,
                      hint: Text("Competition",
                          style: TextStyle(
                              fontFamily: 'Poppins-Bold', fontSize: 30),
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
                            TextStyle(fontFamily: 'Poppins-Bold', fontSize: 30),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: weightController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Weight',
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: TextFormField(
                        style:
                            TextStyle(fontFamily: 'Poppins-Bold', fontSize: 30),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: weightController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Frame Length',
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: TextFormField(
                        style:
                            TextStyle(fontFamily: 'Poppins-Bold', fontSize: 30),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: weightController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Frame Width',
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
                              child: Center(child: Text(value, style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 13, color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("Height",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 30),
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
                          items: <String>['4 Wheel Drivetrain', '6 Wheel Drivetrain', '8 Wheel Drivetrain', 'Treads', 'Omni', 'Swerve', 'Other']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(child: Text(value, style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 17, color: Colors.black)),
                              ),
                            );
                          }).toList(),
                          hint: Text("DriveTrain",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 30),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    
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
