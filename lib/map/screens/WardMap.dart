import 'package:flutter/material.dart';
import 'package:garbage_master/map/helpers/shared_prefs.dart';
import 'package:mapbox_gl/mapbox_gl.dart';


class WardMap extends StatefulWidget {
  const WardMap({Key? key}) : super(key: key);

  @override
  State<WardMap> createState() => _WardMapState();
}

class _WardMapState extends State<WardMap> {
  // Mapbox related
  LatLng latLng = getLatLngFromSharedPrefs();
  late CameraPosition _inittialCameraPosition;
  late MapboxMapController controller;
  // Carousel related

  @override
  void initState() {
    super.initState();
    _inittialCameraPosition = CameraPosition(
      target: latLng,
      zoom: 15.0,
    );
    // Calculate the distance and time from data in SharedPreferences

    // Generate the list of carousel widgets

    // initialize map symbols in the same order as carousel widgets
  }

  _addSourceAndLineLayer(int index, bool removeLayer) async {
    // Can animate camera to focus on the item

    // Add a polyLine between source and destination

    // Remove lineLayer and source if it exists

    // Add new source and lineLayer
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Garbage Map'),
      // ),
      body: SafeArea(
        child: Center(
            child: Stack(
          children: [
            Text("Hi"),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              child: MapboxMap(
                accessToken:'pk.eyJ1Ijoia3VyaXNpb24iLCJhIjoiY2xiZnRnZGJpMDhjdzNvbXU4bzFhb2Q1MyJ9.vJzZeGHtxsyHMst4Kic9Uw',
                initialCameraPosition: _inittialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
              ),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.animateCamera(
            CameraUpdate.newCameraPosition(_inittialCameraPosition),
          );
          // Add your onPressed code here!
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
