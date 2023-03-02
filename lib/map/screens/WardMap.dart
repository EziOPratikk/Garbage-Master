import 'package:flutter/material.dart';
import 'package:garbage_master/map/helpers/shared_prefs.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class GarbageMap extends StatefulWidget {
  const GarbageMap({Key? key}) : super(key: key);

  @override
  State<GarbageMap> createState() => _GarbageMapState();
}

class _GarbageMapState extends State<GarbageMap> {
  LatLng latlng = getLatLngFromSharedPrefs();
  late List<Model> data;
  late MapShapeSource dataSource;
  // late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  late MapZoomPanBehavior _zoomPanBehavior;
  final MapShapeLayerController _layerController = MapShapeLayerController();

  @override
  void dispose() {
    _layerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    data = <Model>[
      const Model('Ward1', 5),
      const Model('Ward2', 10),
      const Model('Ward3', 20),
      const Model('Ward4', 12),
      const Model('Ward5', 15),
      const Model('Ward6', 16),
      const Model('Ward7', 7),
      const Model('Ward8', 8),
      const Model('Ward9', 22),
      const Model('Ward10', 15),
      const Model('Ward11', 22),
      const Model('Ward12', 30),
      const Model('Ward13', 24),
      const Model('Ward14', 31),
      const Model('Ward15', 32),
      const Model('Ward16', 35),
      const Model('Ward17', 36),
      const Model('Ward18', 19),
      const Model('Ward19', 18),
      const Model('Ward20', 20),
      const Model('Ward21', 36),
      const Model('Ward22', 37),
      const Model('Ward23', 10),
      const Model('Ward24', 21),
      const Model('Ward25', 22),
      const Model('Ward26', 30),
      const Model('Ward27', 17),
      const Model('Ward28', 18),
      const Model('Ward29', 16),
      const Model('Ward30', 25),
      const Model('Ward31', 35),
      const Model('Ward32', 32),
    ];

    dataSource = MapShapeSource.asset(
      "assets/ward.geojson",
      shapeDataField: "name",
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].ward,
      shapeColorValueMapper: (int index) => data[index].count,
      shapeColorMappers: [
        const MapColorMapper(
            from: 0,
            to: 9,
            color: Color(0xff10974c),
            minOpacity: 0.7,
            maxOpacity: 0.7),
        const MapColorMapper(
            from: 10,
            to: 19,
            color: Color(0xffdab600),
            minOpacity: 0.7,
            maxOpacity: 0.7),
        const MapColorMapper(
            from: 20,
            to: 50,
            color: Color(0xffe53935),
            minOpacity: 0.7,
            maxOpacity: 0.7),
      ],
    );
    super.initState();
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: MapLatLng(latlng.latitude, latlng.longitude),
      zoomLevel: 0.5,
      minZoomLevel: 13,
      maxZoomLevel: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfMaps(
          layers: [
            MapTileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              initialFocalLatLng: MapLatLng(latlng.latitude, latlng.longitude),
              initialZoomLevel: 15,
              zoomPanBehavior: _zoomPanBehavior,
              sublayers: [
                MapShapeSublayer(
                  controller: _layerController,
                  source: dataSource,
                  strokeColor: Colors.white,
                  strokeWidth: 2,
                  markerBuilder: (BuildContext context, int index) {
                    return MapMarker(
                      latitude: latlng.latitude,
                      longitude: latlng.longitude,
                      child: Icon(
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _layerController.insertMarker(0);
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}

class Model {
  const Model(this.ward, this.count);
  final String ward;
  final double count;
}
