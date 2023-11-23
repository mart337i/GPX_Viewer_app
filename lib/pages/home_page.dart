import 'package:app_gpx_viewer/pages/map_page.dart';
import 'package:app_gpx_viewer/pages/route_selection_page.dart';
import 'package:app_gpx_viewer/pages/upload_file.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                  child: const MapPage(),
              ),
              Container(
                alignment: Alignment.center,
                child: const UploadFile(),
              ),
            ][_selectedIndex],
          );
        }
      }