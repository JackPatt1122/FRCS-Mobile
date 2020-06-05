import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class PersonalPitEntries extends StatefulWidget {
  @override
  _PersonalPitEntriesState createState() => _PersonalPitEntriesState();

  final String text;

  PersonalPitEntries({Key key, @required this.text}) : super(key: key);

}

class _PersonalPitEntriesState extends State<PersonalPitEntries> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Accept": "application/json"
      }
    );

    this.setState(() {
      data = json.decode(response.body);
    });
    
    print(data[1]["title"]);
    
    return "Success!";
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            child: new Text(data[index]["title"]),
          );
        },
      ),
      ),
      
    );
  }
}