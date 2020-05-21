import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:sliding_sheet/sliding_sheet.dart';


class ListDetail extends StatelessWidget {
  final String text;

  ListDetail({Key key, @required this.text}) : super(key: key);

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/pit/" + text),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body));
  }

  @override
 Widget build(BuildContext context) {

  

  return Scaffold(
    backgroundColor: Colors.grey.shade200,
    body: SlidingSheet(
      
      
      elevation: 8,
      cornerRadius: 30,
      snapSpec: const SnapSpec(
        // Enable snapping. This is true by default.
        snap: true,
        // Set custom snapping points.
        snappings: [0.1, 0.7, 1.0],
        // Define to what the snappings relate to. In this case, 
        // the total available space that the sheet can expand to.
        positioning: SnapPositioning.relativeToAvailableSpace,
        
      ),
      
      
      // The body widget will be displayed under the SlidingSheet
      // and a parallax effect can be applied to it.
      body: Container(
        child: Text("TEST")

      ),
      
      builder: (context, state) {
        // This is the content of the sheet that will get
        // scrolled, if the content is bigger than the available
        // height of the sheet.
        return Container(
          height: 500,
          child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
           child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 7,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey
                
              ),
            )
          ),),
         
        );
      },
    ),
  );
}
}
