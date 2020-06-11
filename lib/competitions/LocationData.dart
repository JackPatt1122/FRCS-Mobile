import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CompetitionLocation extends StatefulWidget {
  @override
  CompetitionLocationState createState() => CompetitionLocationState();

  String location;
  String place;

    CompetitionLocation({Key key, @required this.location, this.place}) : super(key: key);
  
}

class CompetitionLocationState extends State<CompetitionLocation> {
  Completer<GoogleMapController> _controller = Completer();

  double lat;
  double long;

  GoogleMapController _mapController;

  Set<Marker> _markers = HashSet<Marker>();

    Future getLocation() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://www.thebluealliance.com/api/v3/event/2020nyli2"),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key":
              "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    setState(() {

      lat = json.decode(response.body)['lat'];
      long = json.decode(response.body)['lng'];
      print(json.decode(response.body)['lat']);
      print(json.decode(response.body)['lng']);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
      _mapController = controller;

    _controller.complete(controller);

    setState(() {
      _markers.add(Marker(markerId: MarkerId("0"), position: LatLng(lat, long)));
    });



  }

  



  @override
  void initState() {
    super.initState();
    print(widget.place);
    getLocation();
  }


  @override
  Widget build(BuildContext context) {

    

    return MaterialApp(
      home: Scaffold(
        body: Stack(children: <Widget>[
          
        GoogleMap(onMapCreated: _onMapCreated, initialCameraPosition: CameraPosition(
          target: LatLng(lat, long),
          zoom: 12
          
        ),markers: _markers, ),
        SafeArea(child: Align(alignment: Alignment.topLeft, child:
           Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
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
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
           ),
           ),
        ),
        ],) 
      ),
    );
  }
}

