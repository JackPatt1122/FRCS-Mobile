import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:bloc_login/profile/profile.dart';
import 'package:bloc_login/data/PitList.dart';
import 'package:bloc_login/data/MatchList.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

  
}

class _HomeState extends State<Home> {

   //State class
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();


  final _profilePage = Profile();
  final _pitStatsPage = PitList();
  final _matchStatsPage = MatchList();

  Widget _showPage = Profile();


  Widget _pageChooser(int page){
    switch(page){
      case 0:
        return _matchStatsPage;
        break;
      case 1:
        return _pitStatsPage;
        break;
      case 2: 
        return _profilePage;
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          buttonBackgroundColor: Colors.white,
          backgroundColor: Color.fromRGBO(241, 244, 251, 1),
          height: 55,
          
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.insert_chart, size: 30),
            Icon(Icons.clear_all, size: 30),
            Icon(Icons.account_circle, size: 30),
          ],
          onTap: (int tappedIndex) {
            setState(() {
              _showPage = _pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _showPage,
          ),
        ));
  }
}