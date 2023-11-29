import 'package:app_gpx_viewer/pages/map_page.dart';
import 'package:app_gpx_viewer/pages/route_selection_page.dart';
import 'package:app_gpx_viewer/pages/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  final Set<Polyline>? initialPolylines; 

  const HomePage({super.key, this.initialPolylines});

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  Set<Polyline> _polylines = Set();


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    // Set the initial polylines if provided
    if (widget.initialPolylines != null) {
      _polylines = widget.initialPolylines!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Public Routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file_outlined),
            label: 'Upload file',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const RouteSelectionPage(),
        ),
        Container(
            alignment: Alignment.center,
            child: MapPage(initialPolylines: _polylines),
        ),
        Container(
          alignment: Alignment.center,
          child: const UploadFile(),
        ),
      ][_selectedIndex],
    );
  }
}