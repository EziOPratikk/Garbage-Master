import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';
import './history_table.dart';
import '../UI/homepage/widgets/recent_data.dart';

class APIServices {
  static String registerUserUrl =
      'http://192.168.1.70:85/ProjectAPI/RegisterUser';

  static String loginUserUrl = 'http://192.168.1.70:85/ProjectAPI/LoginUser';

  static String contactUsUrl =
      'http://192.168.1.70:85/ProjectAPI/InsertMessage';

  static String sendEmailUrl = 'http://192.168.1.70:85/ProjectAPI/SendEmail';

  static String checkEmailUrl = 'http://192.168.1.70:85/ProjectAPI/CheckEmail';

  static String resetPasswordUrl =
      'http://192.168.1.70:85/ProjectAPI/ResetPassword';

  static String currentUserUrl =
      'http://192.168.1.70:85/ProjectAPI/GetSpecificUser';

  static String updateGarbageDataUrl =
      'http://192.168.1.70:85/ProjectAPI/UpdateGarbageData';

  static String updateProfileUrl =
      'http://192.168.1.70:85/ProjectAPI/UpdateProfile';

  static String getAvgUrl = 'http://192.168.1.70:85/ProjectAPI/getAverage';

  static String historyTableUrl =
      'http://192.168.1.70:85/ProjectAPI/HistoryTable';

  static String insertImageUrl =
      'http://192.168.1.70:85/ProjectAPI/InsertImage';

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

  static Future<http.Response> insertImage(Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse(insertImageUrl),
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "accept": "*/*"},
    );

    log(response.body.toString());

    return response;
  }

  static Future<Map<String, dynamic>> getWards() async {
    final response = await http.get(Uri.parse(getAvgUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load wards');
    }
  }

  Future<http.Response> getCoordinates(
      LatLng startCoord, LatLng endCoord) async {
    const String apiUrl = "http://192.168.1.70:8000";
    final response = await http.post(Uri.parse(apiUrl),
        body: jsonEncode({
          "start_coord": [startCoord.latitude, startCoord.longitude],
          "end_coord": [endCoord.latitude, endCoord.longitude],
        }),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to get coordinates from API");
    }
  }
}
