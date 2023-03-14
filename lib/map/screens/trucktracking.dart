import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GarbageMap extends StatefulWidget {
  final List<Map<String, dynamic>> wardList;
  const GarbageMap({super.key, required this.wardList});

  @override
  _GarbageMapState createState() => _GarbageMapState();
}

class _GarbageMapState extends State<GarbageMap> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Polygon> _polygons = {};

  @override
  void initState() {
    super.initState();

    loadPolygons();
  }

  Future<void> loadPolygons() async {
    final data = await rootBundle.loadString('assets/ward.geojson');
    final features = jsonDecode(data)['features'];

    Set<Polygon> polygons = {};
    for (final feature in features) {
      final geometry = feature['geometry'];
      final coordinates = geometry['coordinates'][0];
      List<LatLng> polygonLatLngs = [];
      for (final coordinate in coordinates) {
        polygonLatLngs.add(LatLng(coordinate[1], coordinate[0]));
      }
      final properties = feature['properties'];
      //Get the ward from the database using the ward name
      final ward = widget.wardList.firstWhere((ward) =>
          ward["wardName"] == properties['name'].toString().toLowerCase());
      final wardAverage = ward["average"];
      final polygon = Polygon(
        polygonId: PolygonId(properties['name']),
        points: polygonLatLngs,
        strokeColor: Color(
            int.parse(properties['stroke'].substring(1, 7), radix: 16) +
                0x80000000),
        strokeWidth: properties['stroke-width'].toInt(),
        fillColor: getFillColor(wardAverage),
      );
      polygons.add(polygon);
    }
    setState(() {
      _polygons = polygons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GARBAGE MAP'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GoogleMap(
        minMaxZoomPreference: const MinMaxZoomPreference(12, 15),
        myLocationButtonEnabled: false,
        initialCameraPosition:
            const CameraPosition(target: LatLng(27.6975, 85.3289), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        polygons: _polygons,
      ),
    );
  }
}

Color getFillColor(int average) {
  if (average <= 8) {
    return const Color(0xff10974c).withOpacity(0.7);
  } else if (average <= 16) {
    return const Color(0xffdab600).withOpacity(0.7);
  } else {
    return const Color(0xffe53935).withOpacity(0.7);
  }
}
