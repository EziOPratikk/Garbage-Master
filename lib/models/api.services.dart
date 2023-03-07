import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import './history_table.dart';
import '../UI/homepage/widgets/recent_data.dart';

class APIServices {
  static String registerUserUrl =
      'http://192.168.101.7:8484/ProjectAPI/RegisterUser';

  static String loginUserUrl = 'http://192.168.101.7:8484/ProjectAPI/LoginUser';

  static String contactUsUrl =
      'http://192.168.101.7:8484/ProjectAPI/InsertMessage';

  static String sendEmailUrl = 'http://192.168.101.7:8484/ProjectAPI/SendEmail';

  static String checkEmailUrl = 'http://192.168.1.70:83/ProjectAPI/CheckEmail';

  static String resetPasswordUrl =
      'http://192.168.101.7:8484/ProjectAPI/ResetPassword';

  static String currentUserUrl =
      'http://192.168.101.7:8484/ProjectAPI/GetSpecificUser';

  static String updateGarbageDataUrl =
      'http://192.168.101.7:8484/ProjectAPI/UpdateGarbageData';

  static String updateProfileUrl =
      'http://192.168.101.7:8484/ProjectAPI/UpdateProfile';

  static String getAvgUrl = 'http://192.168.101.7:8484/ProjectAPI/getAverage';

  static String historyTableUrl =
      'http://192.168.101.7:8484/ProjectAPI/HistoryTable';

  static Future<http.Response> registerUser(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(registerUserUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );

    return response;
  }

  static Future<http.Response> loginUser(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(loginUserUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );
    // log(map.toString());
    // log(response.toString());
    // log(response.body);
    // log(response.body.toString());
    return response;
  }

  static Future<http.Response> contactUs(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(contactUsUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );

    return response;
  }

  static Future<http.Response> sendEmail(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(sendEmailUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );

    return response;
  }

  static Future<http.Response> checkEmail(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(checkEmailUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );

    return response;
  }

  static Future<http.Response> resetPassword(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(resetPasswordUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );

    return response;
  }

  static Future<http.Response> updateGarbageData(
      Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(updateGarbageDataUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );

    return response;
  }

  // static Future getCurses() async {
  //   final response = await http.get(Uri.parse(course), headers: {
  //     "X-Api-Key":
  //         "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNDY2IiwiZmlyc3RfbmFtZSI6IlN1ZGhpciIsImxhc3RfbmFtZSI6Ik1hbmFuZGhhciIsImVtYWlsIjoibWFuYW5kaGFyc3VkaGlyQGdtYWlsLmNvbSIsInJvbGUiOiJzdHVkZW50Iiwicm9sZV9pZCI6IjMiLCJ2YWxpZGl0eSI6MSwiaW1hZ2UiOiJodHRwczpcL1wvc3R1ZGl5cHJvamVjdC5jb21cL3VwbG9hZHNcL3VzZXJfaW1hZ2VcLzQ2Ni5qcGcifQ.aZML7hb9jVxbBdUX7jMWnNJHjL7vbX2uywVGrLhO20I"
  //   });
  //   List<Register> courseList = ((jsonDecode(response.body)["data"]) as List)
  //       .map((e) => Register.fromMap(e))
  //       .toList();
  //   log((jsonDecode(response.body)["data"]).toString());
  //   return response;
  // }
  static Future<http.Response> currentUser(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(currentUserUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );
    return response;
  }

  //get method
  static Future<http.Response> getAverage() async {
    final response = await http.get(Uri.parse(getAvgUrl));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load average');
    }
  }

  static Future<http.Response> updateProfile(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(updateProfileUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );

    return response;
  }

  static Future<List<HistoryTable>> historyTable(
      Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(APIServices.historyTableUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        RecentData.historyTable.add(HistoryTable.fromMap(index));
      }
      return RecentData.historyTable;
    } else {
      return RecentData.historyTable;
    }
  }
}
