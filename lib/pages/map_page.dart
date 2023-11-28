import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final Set<Polyline>? initialPolylines; // Optional initial polylines

  const MapPage({super.key, this.initialPolylines});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  late GoogleMapController mapController;
  LatLng _center = const LatLng(55.39594, 10.38831); // Default center (Odense)
  Set<Polyline> _polylines = Set();
  Set<Marker> _markers = Set();

  @override
  void initState() {
    super.initState();
    // Set the initial polylines if provided
    if (widget.initialPolylines != null) {
      _polylines = widget.initialPolylines!;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _updateCameraPosition(LatLng position, double zoom) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: zoom),
      ),
    );
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
