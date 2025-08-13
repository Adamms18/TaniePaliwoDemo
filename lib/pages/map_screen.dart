import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LatLng polandCenter = LatLng(52.2297, 21.0122);

    return Scaffold(
      appBar: AppBar(
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: polandCenter,
          initialZoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.apka1',
          ),
        ],
      ),
    );
  }
}