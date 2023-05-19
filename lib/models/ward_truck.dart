import 'package:mapbox_gl/mapbox_gl.dart';

class WardModel {
  late final String wardName;
  late LatLng coordinates;

  WardModel({required this.wardName, required this.coordinates});
}
