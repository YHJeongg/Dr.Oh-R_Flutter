import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Hospital extends StatefulWidget {
  const Hospital({super.key});

  @override
  State<Hospital> createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  static const LatLng _kMapCenter = LatLng(37.514575, 127.0495556);

  static const CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 16.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('병원 찾기'),
        elevation: 1,
      ),
      body: Stack(
        children: const <Widget>[
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: _kInitialPosition,
            ),
          ),
        ],
      ),
    );
  }
}
