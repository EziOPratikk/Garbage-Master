import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garbage_master/map/helpers/shared_prefs.dart';
import 'package:garbage_master/models/average.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../models/api.services.dart';

Future<WardAvg> getAverageData() async {
  final AverageData = await APIServices.getAverage();
  var decode = jsonDecode(AverageData.body);
  Map<String, dynamic> map = decode;
  WardAvg wardAvg = WardAvg.fromMap(map);

  return wardAvg;
}

class GarbageMap extends StatefulWidget {
  const GarbageMap({Key? key}) : super(key: key);

  @override
  State<GarbageMap> createState() => _GarbageMapState();
}

class _GarbageMapState extends State<GarbageMap> {
  LatLng latlng = getLatLngFromSharedPrefs();
  Future<WardAvg>? wardAvg = getAverageData();
  late List<Model> data;
  late MapShapeSource dataSource;

  late MapboxMapController controller;
  late MapZoomPanBehavior zoomPanBehavior;
  final MapShapeLayerController layerController = MapShapeLayerController();

  @override
  void dispose() {
    layerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<WardAvg>(
            future: wardAvg,
            builder: (BuildContext context, AsyncSnapshot<WardAvg> snapshot) {
              if (snapshot.hasData) {
                List<Model> data = <Model>[
                  Model('Ward1', snapshot.data!.ward1avg.toDouble()),
                  Model('Ward2', snapshot.data!.ward2avg.toDouble()),
                  Model('Ward3', snapshot.data!.ward3avg.toDouble()),
                  Model('Ward4', snapshot.data!.ward4avg.toDouble()),
                  Model('Ward5', snapshot.data!.ward5avg.toDouble()),
                  Model('Ward6', snapshot.data!.ward6avg.toDouble()),
                  Model('Ward7', snapshot.data!.ward7avg.toDouble()),
                  Model('Ward8', snapshot.data!.ward8avg.toDouble()),
                  Model('Ward9', snapshot.data!.ward9avg.toDouble()),
                  Model('Ward10', snapshot.data!.ward10avg.toDouble()),
                  Model('Ward11', snapshot.data!.ward11avg.toDouble()),
                  Model('Ward12', snapshot.data!.ward12avg.toDouble()),
                  Model('Ward13', snapshot.data!.ward13avg.toDouble()),
                  Model('Ward14', snapshot.data!.ward14avg.toDouble()),
                  Model('Ward15', snapshot.data!.ward15avg.toDouble()),
                  Model('Ward16', snapshot.data!.ward16avg.toDouble()),
                  Model('Ward17', snapshot.data!.ward17avg.toDouble()),
                  Model('Ward18', snapshot.data!.ward18avg.toDouble()),
                  Model('Ward19', snapshot.data!.ward19avg.toDouble()),
                  Model('Ward20', snapshot.data!.ward20avg.toDouble()),
                  Model('Ward21', snapshot.data!.ward21avg.toDouble()),
                  Model('Ward22', snapshot.data!.ward22avg.toDouble()),
                  Model('Ward23', snapshot.data!.ward23avg.toDouble()),
                  Model('Ward24', snapshot.data!.ward24avg.toDouble()),
                  Model('Ward25', snapshot.data!.ward25avg.toDouble()),
                  Model('Ward26', snapshot.data!.ward26avg.toDouble()),
                  Model('Ward27', snapshot.data!.ward27avg.toDouble()),
                  Model('Ward28', snapshot.data!.ward28avg.toDouble()),
                  Model('Ward29', snapshot.data!.ward29avg.toDouble()),
                  Model('Ward30', snapshot.data!.ward30avg.toDouble()),
                  Model('Ward31', snapshot.data!.ward31avg.toDouble()),
                  Model('Ward32', snapshot.data!.ward32avg.toDouble()),
                ];
                MapShapeSource dataSource = MapShapeSource.asset(
                  "assets/ward.geojson",
                  shapeDataField: "name",
                  dataCount: data.length,
                  primaryValueMapper: (int index) => data[index].ward,
                  shapeColorValueMapper: (int index) => data[index].count,
                  shapeColorMappers: [
                    const MapColorMapper(
                        from: 0,
                        to: 8,
                        color: Color(0xff10974c),
                        minOpacity: 0.7,
                        maxOpacity: 0.7),
                    const MapColorMapper(
                        from: 9,
                        to: 16,
                        color: Color(0xffdab600),
                        minOpacity: 0.7,
                        maxOpacity: 0.7),
                    const MapColorMapper(
                        from: 17,
                        to: 1000,
                        color: Color(0xffe53935),
                        minOpacity: 0.7,
                        maxOpacity: 0.7),
                  ],
                );
                MapZoomPanBehavior zoomPanBehavior = MapZoomPanBehavior(
                  focalLatLng: MapLatLng(latlng.latitude, latlng.longitude),
                  zoomLevel: 0.5,
                  minZoomLevel: 13,
                  maxZoomLevel: 15,
                );
                return SfMaps(
                  layers: [
                    MapTileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      initialFocalLatLng:
                          MapLatLng(latlng.latitude, latlng.longitude),
                      initialZoomLevel: 15,
                      zoomPanBehavior: zoomPanBehavior,
                      sublayers: [
                        MapShapeSublayer(
                          controller: layerController,
                          source: dataSource,
                          strokeColor: Colors.white,
                          strokeWidth: 2,
                          markerBuilder: (BuildContext context, int index) {
                            return MapMarker(
                              latitude: latlng.latitude,
                              longitude: latlng.longitude,
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.black,
                                size: 30,
                              ),
                            );
                          },
                          //stoke style
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          layerController.insertMarker(0);
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}

class Model {
  const Model(this.ward, this.count);
  final String ward;
  final double count;
}
