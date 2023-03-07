// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class Tracktruck extends StatefulWidget {
//   const Tracktruck({super.key});

//   @override
//   State<Tracktruck> createState() => _TracktruckState();
// }

// class _TracktruckState extends State<Tracktruck> {
//   final Completer<GoogleMapController> _controller = Completer();
//   final Set<Polygon> _polygons = <Polygon>{};
//   static const LatLng sourceLocation =
//       LatLng(27.711973598671676, 85.33182572748206);

//   List<LatLng> ward1 = [
//     const LatLng(27.711973598671676, 85.33182572748206),
//     const LatLng(27.713629754476244, 85.33244931082248),
//     const LatLng(27.714795182374928, 85.33238002378454),
//     const LatLng(27.71497919616786, 85.33168715340787),
//     const LatLng(27.715592573236464, 85.33175644044593),
//     const LatLng(27.71596059782111, 85.33092499599132),
//     const LatLng(27.714856520340675, 85.33064784784102),
//     const LatLng(27.715163209651138, 85.32960854227423),
//     const LatLng(27.717248674087998, 85.33030141265272),
//     const LatLng(27.717739365806324, 85.32773779225471),
//     const LatLng(27.71731001067303, 85.32482773666828),
//     const LatLng(27.718046047009764, 85.32254126442467),
//     const LatLng(27.71816871924915, 85.31699830140411),
//     const LatLng(27.717003327400462, 85.31602828287532),
//     const LatLng(27.713629754476244, 85.31540469953484),
//     const LatLng(27.708655436418624, 85.31442900691701),
//     const LatLng(27.709464668533002, 85.31717117476688),
//     const LatLng(27.710004153273758, 85.31760131874296),
//     const LatLng(27.71002002043207, 85.31928604931682),
//     const LatLng(27.709718544037784, 85.32199237183613),
//     const LatLng(27.710146957611713, 85.32204613983191),
//     const LatLng(27.709988286113884, 85.32385632907022),
//     const LatLng(27.71002002043207, 85.32591743562443),
//     const LatLng(27.711019646724793, 85.32609666228092),
//     const LatLng(27.71094031163949, 85.32824738216323),
//     const LatLng(27.712717403725804, 85.32873129413531),
//     const LatLng(27.711973598671676, 85.33182572748206)
//   ];
//   List<LatLng> ward2 = [
//     const LatLng(85.3171313755609, 27.71803501159185),
//     const LatLng(85.32251423652076, 27.718037948491613),
//     const LatLng(85.3247454549732, 27.71729058053441),
//     const LatLng(85.32788122144552, 27.717717648565895),
//     const LatLng(85.3302631979015, 27.71721050509271),
//     const LatLng(85.33102187552652, 27.719206103120328),
//     const LatLng(85.33168332790598, 27.720042589369882),
//     const LatLng(85.33102187552652, 27.719791644168495),
//     const LatLng(85.3296044775717, 27.719958941033397),
//     const LatLng(85.32988795716267, 27.720795421507106),
//     const LatLng(85.32809258641817, 27.72121365933758),
//     const LatLng(85.32790360002451, 27.72305388673317),
//     const LatLng(85.32724214764511, 27.723388470194877),
//     const LatLng(85.32563576329545, 27.723639407117986),
//     const LatLng(85.32554127009803, 27.725312305175535),
//     const LatLng(85.32384039255084, 27.725646881706794),
//     const LatLng(85.32298995377795, 27.7246431490331),
//     const LatLng(85.32223400820112, 27.72489408306778),
//     const LatLng(85.31958819868356, 27.725395949404344),
//     const LatLng(85.31835978712218, 27.722970240706843),
//     const LatLng(85.31750934834929, 27.720711773748718),
//     const LatLng(85.31741485515192, 27.719206103120328),
//     const LatLng(85.3171313755609, 27.71803501159185),
//   ];
//   @override
//   void initState() {
//     super.initState();
//     // _polygons.add(Polygon(
//     //   polygonId: const PolygonId('ward1'),
//     //   points: ward1,
//     //   strokeWidth: 5,
//     //   geodesic: true,
//     //   strokeColor: Colors.blue,
//     //   fillColor: Colors.red.withOpacity(0.5),
//     // ));
//     // _polygons.add(Polygon(
//     //   polygonId: const PolygonId('ward2'),
//     //   points: ward1,
//     //   strokeWidth: 5,
//     //   geodesic: true,
//     //   strokeColor: Colors.blue,
//     //   fillColor: Colors.orange.withOpacity(0.5),
//     // ));
//     List<Polygon> _polygons = [
//       Polygon(
//         polygonId: const PolygonId('ward1'),
//         points: ward1,
//         strokeWidth: 5,
//         geodesic: true,
//         strokeColor: Colors.blue,
//         fillColor: Colors.red.withOpacity(0.5),
//       ),
//       Polygon(
//         polygonId: const PolygonId('ward2'),
//         points: ward2,
//         strokeWidth: 5,
//         geodesic: true,
//         strokeColor: Colors.blue,
//         fillColor: Colors.green.withOpacity(0.5),
//       ),
//       // Add more polygons as needed
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: const CameraPosition(
//           target: sourceLocation,
//           zoom: 14.4746,
//         ),
//         polygons: _polygons.toSet(),
//         markers: {
//           const Marker(
//             markerId: MarkerId('sourcePin'),
//             position: sourceLocation,
//           ),
//         },
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackTruck extends StatefulWidget {
  const TrackTruck({super.key});

  @override
  _TrackTruckState createState() => _TrackTruckState();
}

class _TrackTruckState extends State<TrackTruck> {
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
      final polygon = Polygon(
        polygonId: PolygonId(properties['name']),
        points: polygonLatLngs,
        strokeColor: Color(
            int.parse(properties['stroke'].substring(1, 7), radix: 16) +
                0x80000000),
        strokeWidth: properties['stroke-width'].toInt(),
        // strokeOpacity: properties['stroke-opacity'].toDouble(),
        fillColor: Color(
            int.parse(properties['fill'].substring(1, 7), radix: 16) +
                0x80000000),
        // fillOpacity: properties['fill-opacity'].toDouble(),
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
        title: Text('Track Garbage Truck'),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        initialCameraPosition:
            const CameraPosition(target: LatLng(27.6975, 85.3289), zoom: 13),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        polygons: _polygons,
      ),
    );
  }
}
