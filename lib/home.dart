import 'package:flutter/material.dart';
import 'package:bloc_login/profile/profile.dart';
import 'package:bloc_login/data/PitList.dart';
import 'package:bloc_login/data/MatchList.dart';
import 'package:navigation_dot_bar/navigation_dot_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //State class
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  int _currentIndex = 0;
  final List<Widget> _children = [];

  final _profilePage = Profile();
  final _pitStatsPage = PitList();
  final _matchStatsPage = MatchList();

  Widget _showPage = Profile();

  Widget _pageChooser(int page) {
    switch (page) {
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationDotBar(
          activeColor: Colors.black,
          color: Colors.black,
          items: <BottomNavigationDotBarItem>[
            BottomNavigationDotBarItem(
                icon: Icons.insert_chart,
                onTap: () {
                  setState(() {
                    _showPage = _pageChooser(0);
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.clear_all,
                onTap: () {
                  setState(() {
                    _showPage = _pageChooser(1);
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.account_circle,
                onTap: () {
                  setState(() {
                    _showPage = _pageChooser(2);
                  });
                }),
          ],
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _showPage,
          ),
        ));
  }
}
