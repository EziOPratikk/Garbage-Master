import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:garbage_master/map/constants/wards.dart';
LatLng getLatLngFromWardData(int index){
  return LatLng(double.parse(wards[index]['coordinates']['latitude']), double.parse(wards[index]['coordinates']['longitude']));
}