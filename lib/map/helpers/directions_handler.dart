import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:garbage_master/map/constants/wards.dart';
import 'package:garbage_master/map/requests/mapbox_requests.dart';
import '../../main.dart';


Future<Map> getDirectionsAPIResponse(LatLng currentLatLng, int index) async {
  final response = await getCyclingRouteUsingMapbox(
      currentLatLng,
      LatLng(double.parse(wards[index]['coordinates']['latitude']),
          double.parse(wards[index]['coordinates']['longitude'])));
          Map geometry = response['routes'][0]['geometry'];
          num duration = response['routes'][0]['duration'];
          num distance = response['routes'][0]['distance'];
          print('-------------------${wards[index]['name']}-------------------');
          print(distance);
          print(duration);

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };
  return modifiedResponse;
}

void saveDirectionsAPIResponse(int index, String response) {
  sharedPreferences.setString('restaurant--$index', response);
}
