import 'package:app_gpx_viewer/models/trail.dart';
import 'package:flutter/material.dart';

class TrailCard extends StatelessWidget {
    final Trail trail;
    const TrailCard({super.key, required this.trail});
    final String defaultImageAsset = 'static/images/template.jpeg';


  EdgeInsets responsivePadding(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {  // Mobile
      return EdgeInsets.all(2.0);
    } else if (width < 1900) {  // Tablet
      return EdgeInsets.symmetric(vertical: 0, horizontal: 600);
    } else {  // PC
      return EdgeInsets.symmetric(vertical: 0, horizontal: 600);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: responsivePadding(context),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 200,
              child: Image.network(
                trail.imageUrl ?? defaultImageAsset, 
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(trail.name,
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(trail.location ?? 'Unknown Location',
                              style: TextStyle(color: Colors.white, fontSize: 12)),
                          Text('Length: ${trail.length} km • Est. ${trail.estimatedTime}',
                              style: TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                    // Add more widgets for other details
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}