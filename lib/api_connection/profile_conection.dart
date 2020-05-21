import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/dao/user_dao.dart';

  
  Future getUserData() async {
    var token = await UserDao().tokenString();

    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/users/" + '993926b321141ee095220489d811b381b3df63b6'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });


    return Future.value(json.decode(response.body)['username']);
  }

  Future getImageData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/profile/" + '1'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });
    return Future.value(json.decode(response.body)['image']);
  }

  Future getFirstName() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/profile/" + '1'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });
    return Future.value(json.decode(response.body)['first_name']);
  }

  Future getLastName() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/profile/" + '1'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });
    return Future.value(json.decode(response.body)['last_name']);
  }

  Future getMatchEntries() async {
    var user = await getUserData();

    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + '12'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });
    return Future.value(json.decode(response.body)['match_count']);
  }

  Future getPitEntries() async {
    var user = await getUserData();
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + '12'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });
    return Future.value(json.decode(response.body)['pit_count']);
  }

  Future getTeamRole() async {
    var user = await getUserData();

    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + '12'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    if (json.decode(response.body)['is_admin'] == true) {
      return Future.value("Mentor");
    } else {
      return Future.value("Member");
    }
  }

    Future getTeamNum() async {
    var user = await getUserData();
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + '12'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body)['team_num']);
  }

      Future getTeamName() async {
    var response = await http.get(
        Uri.encodeFull("https://www.thebluealliance.com/api/v3/team/frc" + "810"),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key": "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    return Future.value(json.decode(response.body)['nickname']);
  }

    Future getTeamUsers() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/users/"),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token: 993926b321141ee095220489d811b381b3df63b6'
        });

    return Future.value(json.decode(response.body));
  }