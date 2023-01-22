import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:garbage_master/map/constants.dart';
class mapDemo extends StatefulWidget {
  const mapDemo({Key? key}) : super(key: key);

  @override
  State<mapDemo> createState() => _mapDemoState();
}

class _mapDemoState extends State<mapDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(options: MapOptions(
            minZoom: 5,
            maxZoom: 18,
            zoom: 13,
            center: AppConstants.myLocation,
          ),
            children: [
              TileLayer(
                urlTemplate: 'https://api.mapbox.com/styles/v1/kurision/cld7ef355000101t71uoxfiy8/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia3VyaXNpb24iLCJhIjoiY2xiZnRnZGJpMDhjdzNvbXU4bzFhb2Q1MyJ9.vJzZeGHtxsyHMst4Kic9Uw',
              )
            ],

          )
        ],
      ),
    );
  }
}
