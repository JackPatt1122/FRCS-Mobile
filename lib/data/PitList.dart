import 'dart:async';
import 'dart:convert';

import 'package:bloc_login/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'pit_model.dart';

import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:bloc_login/api_connection/profile_conection.dart';

class PitList extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State {
  List data;
  String selectedItem;

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

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromRGBO(241, 244, 251, 1),
        body: new Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 30, 0, 0),
                  child: Text("Pit Entries",
                      style:
                          TextStyle(fontSize: 25, fontFamily: 'Poppins-Bold')),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 12, 0),
                  child: IconButton(
                    
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    icon: FutureBuilder<dynamic>(
                      future: getImageData(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData)
                          return Image.network(
                            '${snapshot.data}',
                            height: 45,
                            width: 45,
                          );
                        return Text("Loading");
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            selected: data[index] == selectedItem,
                            title: Text(
                              data[index]['team_num'].toString(),
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold', fontSize: 20),
                            ),
                            subtitle: FutureBuilder<dynamic>(
                              future: getTeamNameList(
                                  data[index]['team_num'].toString()),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  return Text(
                                    ' ${snapshot.data}',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 15),
                                  );
                                return Text("Loading");
                              },
                            ),
                            onTap: () {
                              setState(() {
                                selectedItem =
                                    data[index]['team_num'].toString();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListDetail(
                                        text: selectedItem,
                                      ),
                                    ));
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: CircularGradientButton(
                child: Icon(Icons.create),
                callback: () {},
                gradient: Gradients.hotLinear,
                shadowColor: Gradients.hotLinear.colors.last.withOpacity(0.5),
              ),
            )
          ],
        ));
  }
}
