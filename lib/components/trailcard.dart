import 'package:app_gpx_viewer/models/trail.dart';
import 'package:flutter/material.dart';

class TrailCard extends StatelessWidget {
  final Trail trail;
  final Function(String) onTrailTap;

  const TrailCard({super.key, required this.trail, required this.onTrailTap});
  final String defaultImageAsset = 'static/images/template.jpeg';

  EdgeInsets responsivePadding(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) { // Mobile
      return EdgeInsets.all(2.0);
    } else if (width < 1900) { // Tablet
      return EdgeInsets.symmetric(vertical: 0, horizontal: 600);
    } else { // PC
      return EdgeInsets.symmetric(vertical: 0, horizontal: 600);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTrailTap(trail.filename), // Call the callback function with the filename when the card is tapped
      child: Padding(
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
                  color: Colors.black.withOpacity(0.5), // Add a translucent overlay to the bottom bar for better readability
                  width: double.infinity,
                  padding: EdgeInsets.all(8), // Add some padding
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              trail.name,
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              trail.location ?? 'Unknown Location',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              'Length: ${trail.length} km • Est. ${trail.estimatedTime}',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      // You can add more widgets here for other details
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
