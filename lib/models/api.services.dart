import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../models/register.dart';

class APIServices {
  static String registerUserUrl =
      'http://192.168.101.5:8484/ProjectAPI/RegisterUser';
  static String loginUserUrl = 'http://192.168.101.5:8484/ProjectAPI/LoginUser';
  // static String course = 'https://studiyproject.com/api/v1/courses';
  static String contactUsUrl =
      'http://192.168.101.5:8484/ProjectAPI/insertmessage';

  static Future<http.Response> registerUser(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(registerUserUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );
    log(map.toString());
    log(response.toString());
    return response;
  }

  static Future<http.Response> loginUser(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(loginUserUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );
    log(map.toString());
    log(response.toString());
    log(response.body);
    log(response.body.toString());
    return response;
  }

  static Future<http.Response> contactUs(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(contactUsUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );
    log(map.toString());
    log(response.toString());
    log(response.body);
    log(response.body.toString());
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
}
