import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'TeamsList.dart';


class CompetitionsDetail extends StatefulWidget {
  @override
  _CompetitionsDetailState createState() => _CompetitionsDetailState();

  String text;

  CompetitionsDetail({Key key, @required this.text}) : super(key: key);
}

class _CompetitionsDetailState extends State<CompetitionsDetail> {



  Future getCompName() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://www.thebluealliance.com/api/v3/event/2019nyli2"),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    return Future.value(json.decode(response.body));
  }




  Future getTeamsAmount() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://www.thebluealliance.com/api/v3/event/2020nyli2/teams"),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    return Future.value(json.decode(response.body));
  }

  Future getCompStartDate() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://www.thebluealliance.com/api/v3/event/2019nyli2"),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });
    var inputString = json.decode(response.body)['start_date'];
    var date = DateTime.parse(inputString);

    switch (date.month) {
      case 1:
        return ("January" + ' ' + date.day.toString() + ' ');
        break;
      case 2:
        return ("February" + ' ' + date.day.toString() + ' ');
        break;
      case 3:
        return ("March" + ' ' + date.day.toString() + ' ');
        break;
      case 4:
        return ("April" + ' ' + date.day.toString() + ' ');
        break;
      case 5:
        return ("May" + ' ' + date.day.toString() + ' ');
        break;
      case 6:
        return ("June" + ' ' + date.day.toString() + ' ');
        break;
      case 7:
        return ("July" + ' ' + date.day.toString() + ' ');
        break;
      case 8:
        return ("August" + ' ' + date.day.toString() + ' ');
        break;
      case 9:
        return ("September" + ' ' + date.day.toString() + ' ');
        break;
      case 10:
        return ("October" + date.day.toString() + ' ');
        break;
      case 11:
        return ("November" + ' ' + date.day.toString() + ' ');
        break;
      case 12:
        return ("Dcember" + ' ' + date.day.toString() + ' ');
        break;
    }
  }

  Future getCompEndDate() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://www.thebluealliance.com/api/v3/event/2019nyli2"),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });
    var inputString = json.decode(response.body)['end_date'];
    var date = DateTime.parse(inputString);

    switch (date.month) {
      case 1:
        return (" January" + ' ' + date.day.toString());
        break;
      case 2:
        return (" February" + ' ' + date.day.toString());
        break;
      case 3:
        return (" March" + ' ' + date.day.toString());
        break;
      case 4:
        return (" April" + ' ' + date.day.toString());
        break;
      case 5:
        return (" May" + ' ' + date.day.toString());
        break;
      case 6:
        return (" June" + ' ' + date.day.toString());
        break;
      case 7:
        return (" July" + ' ' + date.day.toString());
        break;
      case 8:
        return (" August" + ' ' + date.day.toString());
        break;
      case 9:
        return (" September" + ' ' + date.day.toString());
        break;
      case 10:
        return (" October" + date.day.toString());
        break;
      case 11:
        return (" November" + ' ' + date.day.toString());
        break;
      case 12:
        return (" Dcember" + ' ' + date.day.toString());
        break;
    }
  }
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Column(children: <Widget>[
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: FutureBuilder<dynamic>(
                  future: getCompName(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData)
                      return Text(
                          '${snapshot.data['event_code']}'.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Poppins-Bold', fontSize: 30));
                    return Text("Loading",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold',
                            fontSize: 30,
                            color: Colors.white));
                  },
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: FutureBuilder<dynamic>(
              future: getCompName(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData)
                  return Text('${snapshot.data['name']}',
                      style: TextStyle(
                          fontFamily: 'Poppins-SemiBold', fontSize: 15));
                return Text("Loading",
                    style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 25,
                        color: Colors.white));
              },
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      color: Colors.white,
                    ),
                    height: double.infinity,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 25, top: 20),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xFF78FEA4),
                                      offset: Offset(0, 10),
                                      blurRadius: 30)
                                ],
                                color: Color(0xFF38FF7A),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Icon(Icons.check, color: Colors.white, size: 50,)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 110, 25, 0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                           boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, .2),
                                      offset: Offset(30, 30),
                                      blurRadius: 60)
                                ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FutureBuilder<dynamic>(
                                  future: getCompStartDate(),
                                  builder: (context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData)
                                      return Text('${snapshot.data}',
                                          style: TextStyle(
                                              fontFamily: 'Poppins-SemiBold',
                                              fontSize: 25));
                                    return Text("Loading",
                                        style: TextStyle(
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 25,
                                            color: Colors.black));
                                  },
                                ),
                                Image.asset('assets/icons/arrow-right.png',
                                    height: 20, width: 20),
                                FutureBuilder<dynamic>(
                                  future: getCompEndDate(),
                                  builder: (context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData)
                                      return Text('${snapshot.data}',
                                          style: TextStyle(
                                              fontFamily: 'Poppins-SemiBold',
                                              fontSize: 25));
                                    return Text("Loading",
                                        style: TextStyle(
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 25,
                                            color: Colors.black));
                                  },
                                ),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 70,
                              width: 145,
                              decoration: BoxDecoration(
                                 boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, .2),
                                      offset: Offset(30, 30),
                                      blurRadius: 60)
                                ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(child: FutureBuilder<dynamic>(
                                future: getCompName(),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    return Text('${snapshot.data['city']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 20));
                                  return Text("Loading",
                                      style: TextStyle(
                                          fontFamily: 'Poppins-SemiBold',
                                          fontSize: 20,
                                          color: Colors.black));
                                },
                              ),
                            ),
                            ),
                            FutureBuilder<dynamic>(
                  future: getCompName(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData)
                      return GestureDetector(onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CompetitionTeamList(
                                              text:
                                                  '${snapshot.data['event_code']}'.toString(),
                                            ),
                                          )), child: Container(
                              height: 70,
                              width: 145,
                              decoration: BoxDecoration(
                                 boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, .2),
                                      offset: Offset(30, 30),
                                      blurRadius: 60)
                                ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                                      child: Center(child: FutureBuilder<dynamic>(
                                future: getTeamsAmount(),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    return Text('${snapshot.data.length}' + " Teams",
                                        style: TextStyle(
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 20));
                                  return Text("Loading",
                                      style: TextStyle(
                                          fontFamily: 'Poppins-SemiBold',
                                          fontSize: 20,
                                          color: Colors.black));
                                },
                              ),
                            ),
                            ),);
                    return null;
                  },
                ),
                            
                            
                            
                            
                          ],
                        ),
                      ),
                       
                      
                    ],
                  ),
                  
                ),
                
              ],
            ),
          ),
          
        ]),
      ),
    );
  }
}
