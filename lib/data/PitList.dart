import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'pit_model.dart';

import 'package:gradient_widgets/gradient_widgets.dart';


class PitList extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State {
  List data;
  String selectedItem;

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
            ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  selected: data[index] == selectedItem,
                  title: Text(
                    data[index]['team_num'].toString(),
                    style: TextStyle(fontFamily: 'Poppins-Bold', fontSize: 20),
                    
                  ),
                  onTap: () {
                    setState(() {
                      selectedItem = data[index]['team_num'].toString();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListDetail(
                              text: selectedItem,
                            ),
                          ));
                    });
                  },
                );
              },
              
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: CircularGradientButton(
              
              child: Icon(Icons.create),
              callback: () {},
              gradient: Gradients.hotLinear,
              shadowColor: Gradients.hotLinear.colors.last.withOpacity(0.5),
            ),)
            
          ],
        ));

  }
}
