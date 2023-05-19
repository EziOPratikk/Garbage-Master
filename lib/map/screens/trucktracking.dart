import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../keys.dart';
import '../../models/api.services.dart';
import '../../models/ward_truck.dart';
import '../helpers/shared_prefs.dart';

class TrackTruck extends StatefulWidget {
  const TrackTruck({super.key});

  @override
  State<TrackTruck> createState() => _TrackTruckState();
}

class _TrackTruckState extends State<TrackTruck> {
  Key mapKey = UniqueKey();
  LatLng latlng = getLatLngFromSharedPrefs();
  LatLng selectedCoordinates = const LatLng(0, 0);
  late CameraPosition _initialPosition;
  late MapboxMapController mapController;
  List<LatLng> polylineCoordinates = [];
  APIServices apiServices = APIServices();

  List<WardModel> truckward = [
    WardModel(wardName: "Ward1", coordinates: const LatLng(27.71341, 85.32344)),
    WardModel(
        wardName: "Ward2", coordinates: const LatLng(27.721429, 85.324407)),
    WardModel(wardName: "Ward3", coordinates: const LatLng(27.73585, 85.32893)),
    WardModel(wardName: "Ward4", coordinates: const LatLng(27.72622, 85.33406)),
    WardModel(
        wardName: "Ward5", coordinates: const LatLng(27.716107, 85.335164)),
    WardModel(wardName: "Ward6", coordinates: const LatLng(27.72596, 85.3604)),
    WardModel(wardName: "Ward7", coordinates: const LatLng(27.71811, 85.3497)),
    WardModel(wardName: "Ward8", coordinates: const LatLng(27.7106, 85.35266)),
    WardModel(wardName: "Ward9", coordinates: const LatLng(27.69641, 85.34961)),
    WardModel(
        wardName: "Ward10", coordinates: const LatLng(27.69163, 85.33224)),
    WardModel(wardName: "Ward11", coordinates: const LatLng(27.6933, 85.31829)),
    WardModel(
        wardName: "Ward12", coordinates: const LatLng(27.696382, 85.304089)),
    WardModel(wardName: "Ward13", coordinates: const LatLng(27.7021, 85.29218)),
    WardModel(
        wardName: "Ward14", coordinates: const LatLng(27.69221, 85.29201)),
    WardModel(
        wardName: "Ward15", coordinates: const LatLng(27.71359, 85.29274)),
    WardModel(
        wardName: "Ward16", coordinates: const LatLng(27.72447, 85.29806)),
    WardModel(
        wardName: "Ward17", coordinates: const LatLng(27.711734, 85.305828)),
    WardModel(
        wardName: "Ward18", coordinates: const LatLng(27.709479, 85.305188)),
    WardModel(
        wardName: "Ward19", coordinates: const LatLng(27.706792, 85.304434)),
    WardModel(
        wardName: "Ward20", coordinates: const LatLng(27.703492, 85.303991)),
    WardModel(
        wardName: "Ward21", coordinates: const LatLng(27.698296, 85.30707)),
    WardModel(
        wardName: "Ward22", coordinates: const LatLng(27.701686, 85.310865)),
    WardModel(
        wardName: "Ward23", coordinates: const LatLng(27.701871, 85.30707)),
    WardModel(
        wardName: "Ward24", coordinates: const LatLng(27.705821, 85.307952)),
    WardModel(
        wardName: "Ward25", coordinates: const LatLng(27.70713, 85.309813)),
    WardModel(
        wardName: "Ward26", coordinates: const LatLng(27.72153, 85.31442)),
    WardModel(
        wardName: "Ward27", coordinates: const LatLng(27.70997, 85.313021)),
    WardModel(
        wardName: "Ward28", coordinates: const LatLng(27.70432, 85.31824)),
    WardModel(wardName: "Ward29", coordinates: const LatLng(27.69805, 85.3283)),
    WardModel(
        wardName: "Ward30", coordinates: const LatLng(27.707868, 85.329649)),
    WardModel(
        wardName: "Ward31", coordinates: const LatLng(27.69009, 85.34114)),
    WardModel(
        wardName: "Ward32", coordinates: const LatLng(27.686418, 85.344552)),
  ];
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
      body: Form(
        child: Stack(children: [
          SizedBox(
            key: mapKey,
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
                LatLng endCoordinates = LatLng(selectedCoordinates.latitude,
                    selectedCoordinates.longitude);

                final aStarResult = await apiServices.getCoordinates(
                    startCoordinates, endCoordinates);
                final decoded = jsonDecode(aStarResult.body);

                List<LatLng> points = [];

                final coordi = decoded['coordinates'];

                for (var i = 0; i < coordi.length; i++) {
                  var line = coordi[i];
                  var longitude = line[0];
                  var latitude = line[1];
                  var latLng = LatLng(latitude, longitude);
                  points.add(latLng);
                }
                routeCoordinates.clear();
                routeCoordinates.addAll(points);

                // Add the LineString object to the map using a LineLayer
                mapController.clearLines();
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
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  hintText: 'Select Ward',
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
                items: truckward.map((WardModel item) {
                  return DropdownMenuItem(
                    value: item.coordinates,
                    child: Text(item.wardName),
                  );
                }).toList(),
                onChanged: (LatLng? value) {
                  setState(() {
                    selectedCoordinates = value ?? LatLng(0.0, 0.0);
                  });
                  mapKey = UniqueKey();
                }),
          ),
        ]),
      ),
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
