import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:mapbox_polyline_points/mapbox_polyline_points.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../../keys.dart';
import '../helpers/shared_prefs.dart';

class TrackTruck extends StatefulWidget {
  const TrackTruck({super.key});

  @override
  State<TrackTruck> createState() => _TrackTruckState();
}

class _TrackTruckState extends State<TrackTruck> {
  LatLng latlng = getLatLngFromSharedPrefs();
  late CameraPosition _initialPosition;
  late MapboxMapController mapController;
  List<LatLng> polylineCoordinates = [];
  void initState() {
    super.initState();
    _initialPosition = CameraPosition(
      target: latlng,
      zoom: 15,
    );
  }

  void onMapCreated(MapboxMapController controller) async {
    this.mapController = controller;

    // Create a LineString object that defines the route
    final routeCoordinates = <LatLng>[
      LatLng(27.751478, 85.298530),
      LatLng(27.753064, 85.300568),
      LatLng(27.751583, 85.302295),
      LatLng(27.751478, 85.298530),
    ];

    // Add the LineString object to the map using a LineLayer
    controller.addLine(
      LineOptions(
        geometry: routeCoordinates,
        lineColor: "#FF0000",
        lineWidth: 3.0,
      ),
    );

    // Add markers for the start and end points of the route
    controller.addSymbol(
      SymbolOptions(
        geometry: routeCoordinates.first,
        iconImage: "airport-15",
      ),
    );
    controller.addSymbol(
      SymbolOptions(
        geometry: routeCoordinates.last,
        iconImage: "airport-15",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Truck'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: MapboxMap(
            accessToken: MyKeys.mapBoxAccessToken,
            initialCameraPosition: _initialPosition,
            onMapCreated: onMapCreated,
            myLocationEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
            onStyleLoadedCallback: () async {
              // Create a LineString object that defines the route
              final routeCoordinates = <LatLng>[];

              MapboxpolylinePoints mapboxPolylinePoints =
                  MapboxpolylinePoints();
              MapboxPolylineResult result =
                  await mapboxPolylinePoints.getRouteBetweenCoordinates(
                MyKeys.mapBoxAccessToken,
                PointLatLng(
                    latitude: latlng.latitude, longitude: latlng.longitude),
                PointLatLng(latitude: 27.7774731, longitude: 85.2445225),
                TravelType.driving,
              );
              print(result.points);
              List<LatLng> decodeEncodedPolyline(List<PointLatLng> encoded) {
                List<LatLng> poly = [];
                for (int i = 0; i < encoded.length; i++) {
                  poly.add(LatLng(encoded[i].latitude, encoded[i].longitude));
                }
                return poly;
              }

              routeCoordinates.addAll(decodeEncodedPolyline(result.points[0]));

              // Add the LineString object to the map using a LineLayer
              mapController.addLine(
                LineOptions(
                  geometry: routeCoordinates,
                  lineColor: "#FF0000",
                  lineWidth: 3.0,
                ),
              );

              // Add markers for the start and end points of the route
              mapController.addSymbol(
                SymbolOptions(
                  geometry: routeCoordinates.first,
                  iconImage: "airport-15",
                ),
              );
              mapController.addSymbol(
                SymbolOptions(
                  geometry: routeCoordinates.last,
                  iconImage: "airport-15",
                ),
              );
            },
          ),
        ),
        // Positioned(
        //   bottom: 0,
        //   left: MediaQuery.of(context).size.width * 0.4,
        //   child: SizedBox(
        //     child: Card(
        //       child: Column(
        //         children: [
        //           IconButton(
        //               iconSize: 40,
        //               onPressed: () {
        //                 LatLng destination = LatLng(
        //                     27.727251, 85.304677); // your destination point
        //               },
        //               icon: Icon(Icons.fire_truck))
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: latlng, zoom: 15)));
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
