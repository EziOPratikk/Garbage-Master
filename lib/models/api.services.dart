import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class APIServices {
  static String registerUserUrl = '';
  static String loginUserUrl = '';

  static Future registerUser(Map<String, dynamic> map) async {
    return await http.post(Uri.parse(registerUserUrl), body: map);
  }

  static Future loginUser(Map<String, dynamic> map) async {
    return await http.post(Uri.parse(loginUserUrl), body: map);
  }
}
