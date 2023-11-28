import 'package:app_gpx_viewer/components/custom_text_field.dart';
import 'package:app_gpx_viewer/components/trail_card_static.dart';
import 'package:app_gpx_viewer/components/trailcard.dart';
import 'package:app_gpx_viewer/models/trail.dart';
import 'package:app_gpx_viewer/pages/map_page.dart';
import 'package:app_gpx_viewer/service/trails_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteSelectionPage extends StatefulWidget {
  const RouteSelectionPage({super.key});

  @override
  State<RouteSelectionPage> createState() => _RouteSelectionPageState();
}

class _RouteSelectionPageState extends State<RouteSelectionPage> {  
  final fuzzySearchController = TextEditingController();
  final trails = TrailService().fetchTrails();

  void getFile(BuildContext context, String filename) async {
    try {
      Set<Polyline> polylines = await TrailService().getTrail(filename);
      // Pass the polylines to the MapPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapPage(initialPolylines: polylines),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching trail data: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Trails",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              controller: fuzzySearchController,
              obscure: false,
              hintText: "Search for a trail:"  
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Trail>>(
              future: trails, // This should be the future stored in the state
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No trails found"));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      // Pass the getFile function as a callback to TrailCard
                      return TrailCard(
                        trail: snapshot.data![index],
                        onTrailTap: (filename) => getFile(context, filename), // Pass a closure that calls getFile with context and filename
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}