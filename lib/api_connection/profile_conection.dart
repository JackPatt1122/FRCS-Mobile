import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:bloc_login/dao/user_dao.dart';

  
  Future getUserData() async {
    var token = await UserDao().getToken(0);

    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/users/" + token),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });


    return Future.value(json.decode(response.body)['username']);
  }

   Future getTeamData() async {
    var token = await UserDao().getToken(0);

    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/users/" + token),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });


    return Future.value(json.decode(response.body)['username']);
  }

  getProfileData() async {
    var token = await UserDao().getToken(0);
    var user = await getUserData();
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + user),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });


    return Future.value(json.decode(response.body)['profile']);
  }



  Future getImageData() async {
    var token = await UserDao().getToken(0);
    var profile = await getUserData();
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + profile),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });
    return Future.value(json.decode(response.body)['profile']['image']);
  }

  Future getFirstName() async {
    var token = await UserDao().getToken(0);
    var profile = await getUserData();

    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + profile),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });
    return Future.value(json.decode(response.body)['profile']['first_name']);
  }

  Future getLastName() async {
    var token = await UserDao().getToken(0);
    var profile = await getUserData();

    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + profile),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });
    return Future.value(json.decode(response.body)['profile']['last_name']);
  }

  Future getMatchEntries() async {
    var token = await UserDao().getToken(0);
    var user = await getUserData();

    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + user),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });
    return Future.value(json.decode(response.body)['match_count']);
  }

  Future getPitEntries() async {
    var token = await UserDao().getToken(0);
    var user = await getUserData();
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + user),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });
    return Future.value(json.decode(response.body)['pit_count']);
  }

  Future getTeamRole() async {
    var token = await UserDao().getToken(0);
    var user = await getUserData();

    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + user),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });

    if (json.decode(response.body)['is_admin'] == true) {
      return Future.value("Mentor");
    } else {
      return Future.value("Member");
    }
  }

    Future getTeamNum() async {
      var token = await UserDao().getToken(0);
    var user = await getUserData();
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/user/" + user),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });

    return Future.value(json.decode(response.body)['team_num']);
  }

      Future getTeamName() async {
        var token = await UserDao().getToken(0);
    var response = await http.get(
        Uri.encodeFull("https://www.thebluealliance.com/api/v3/team/frc" + "810"),
        headers: {
          "Accept": "application/json",
          "X-TBA-Auth-Key": "PzOW8s1DYGlVkgAsikwVlhy5wZ5Tm85fKSjd0DfiUJFQOGhsReyZEf88EEoAU1Cw"
        });

    return Future.value(json.decode(response.body)['nickname']);
  }

    Future getTeamUsers() async {
      var token = await UserDao().getToken(0);
    var response = await http.get(
        Uri.encodeFull("http://192.168.86.37:8000/api/users/"),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token:' + token
        });

    return Future.value(json.decode(response.body));
  }