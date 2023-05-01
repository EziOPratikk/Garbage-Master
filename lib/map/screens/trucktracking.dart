import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:mapbox_polyline_points/mapbox_polyline_points.dart';

import '../../keys.dart';
import '../../models/api.services.dart';
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
  APIServices apiServices = APIServices();
  @override
  void initState() {
    super.initState();
    _initialPosition = CameraPosition(
      target: latlng,
      zoom: 15,
    );
  }

  void onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRUCK ROUTE'),
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
              final routeCoordinates = <LatLng>[];

              LatLng startCoordinates =
                  LatLng(latlng.latitude, latlng.longitude);
              LatLng endCoordinates = const LatLng(27.7774731, 85.2445225);

              final aStarResult = await apiServices.getCoordinates(
                  startCoordinates, endCoordinates);
              final decoded = jsonDecode(aStarResult.body);

              print(decoded);
              List<LatLng> points = [];

              final coordi = decoded['coordinates'];
              print(coordi);
              for (var i = 0; i < coordi.length; i++) {
                var line = coordi[i];
                var longitude = line[0];
                var latitude = line[1];
                var latLng = LatLng(latitude, longitude);
                points.add(latLng);
              }
              // MapboxpolylinePoints mapboxPolylinePoints =
              //     MapboxpolylinePoints();

              // MapboxPolylineResult result =
              //     await mapboxPolylinePoints.getRouteBetweenCoordinates(
              //   MyKeys.mapBoxAccessToken,
              //   PointLatLng(
              //       latitude: latlng.latitude, longitude: latlng.longitude),
              //   PointLatLng(latitude: 27.7774731, longitude: 85.2445225),
              //   TravelType.driving,
              // );
              // print(result.points);
              // List<LatLng> decodeEncodedPolyline(List<PointLatLng> encoded) {
              //   List<LatLng> poly = [];
              //   for (int i = 0; i < encoded.length; i++) {
              //     poly.add(LatLng(encoded[i].latitude, encoded[i].longitude));
              //   }
              //   return poly;
              // }

              routeCoordinates.addAll(points);

              // Add the LineString object to the map using a LineLayer
              mapController.addLine(
                LineOptions(
                  geometry: routeCoordinates,
                  lineColor: "#5a9747",
                  lineWidth: 3.0,
                ),
              );

              // Add markers for the start and end points of the route
              mapController.addSymbol(
                SymbolOptions(
                  geometry: routeCoordinates.first,
                  iconImage: "aiport-15",
                ),
              );

              void addMarker(
                  MapboxMapController controller, LatLng latLng) async {
                var byteData =
                    await rootBundle.load("assets/images/garbage.png");
                var markerImage = byteData.buffer.asUint8List();

                controller.addImage('marker', markerImage);

                await controller.addSymbol(
                  SymbolOptions(
                    iconSize: 0.3,
                    iconImage: "marker",
                    geometry: routeCoordinates.last,
                  ),
                );
              }
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
