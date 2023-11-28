import 'package:app_gpx_viewer/service/trails_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  late GoogleMapController mapController;
  LatLng _center = const LatLng(55.39594, 10.38831); // Odense
  Set<Polyline> _polylines = Set();
  Set<Marker> _markers = Set();

  final TrailService _debugTrailService = TrailService();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _loadDebugTrails(); // Optionally load trails here if more appropriate
  }

  void _updateCameraPosition(LatLng position, double zoom) {
    _center = LatLng(position.latitude, position.longitude);
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _center, zoom: zoom),
      ),
    );
  }

  Future<void> _loadDebugTrails() async {
    Set<Polyline> debugPolylines = await _debugTrailService.fetchDebugTrailPolyline();
    setState(() {
      _polylines = debugPolylines;
    });
    if (debugPolylines.isNotEmpty) {
      //TODO: Calculate the midle point between cords
      _updateCameraPosition(debugPolylines.first.points.first, 12.0);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        polylines: _polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers,
        initialCameraPosition: CameraPosition(target: _center, zoom: 7.0),
        mapType: MapType.satellite,
      ),
    );
  }
}