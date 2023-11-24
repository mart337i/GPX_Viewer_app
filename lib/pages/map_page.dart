import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
      late GoogleMapController mapController;
      final LatLng _center = const LatLng(0, -180);
      Set<Polyline> _polylines = Set();

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
      _loadGPXAndDisplay();
      _getCurrent_location();
    }

    Future<Position> _getCurrent_location() async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission;
      if (!serviceEnabled) {
        return Future.error("location service disabled");
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      } 

      return await Geolocator.getCurrentPosition();
      
    }

    void _loadGPXAndDisplay() async {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/gpx_test/'));
      final document = XmlDocument.parse(response.body);
      final points = document.findAllElements('trkpt').map((node) {
        return LatLng(
          double.parse(node.getAttribute('lat')!),
          double.parse(node.getAttribute('lon')!),
        );
      }).toList();

    final polyline = Polyline(
      polylineId: PolylineId('route'),
      points: points,
      color: Colors.blue,
      width: 4,
    );

    setState(() {
      _polylines.add(polyline);
    });

    // Optionally, adjust the map's bounds here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        polylines: _polylines,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 3.0,
        ),
        mapType: MapType.satellite,
      ),
    );
  }
}