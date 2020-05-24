import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TeamUsers extends StatefulWidget {
  @override
  TeamUsersState createState() => new TeamUsersState();
}

class TeamUsersState extends State {

  List data;

  Future getData() async {
    var response = await http.get(
      Uri.encodeFull("http://192.168.86.37:8000/api/team/810"),
      headers: {
        "Accept": "application/json"
      }
    );

    this.setState(() {
      data = json.decode(response.body)['team_users'];
    });
    
    print(data);
    
    return "Success!";
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Listviews"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            child: new Text(data[index]),
          );
        },
      ),
    );
  }
}