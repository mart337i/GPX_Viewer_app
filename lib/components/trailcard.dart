import 'package:app_gpx_viewer/models/trail.dart';
import 'package:flutter/material.dart';

class TrailCard extends StatelessWidget {
  final Trail trail;
  final Function(String) onTrailTap;

  const TrailCard({super.key, required this.trail, required this.onTrailTap});
  final String defaultImageAsset = 'static/images/template.jpeg';


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTrailTap(trail.filename), // Call the callback function with the filename when the card is tapped
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          child: SizedBox(
            height: 200,
            width: 600,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: <Widget>[
                  SizedBox(
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
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ),
      ),
    );
  }
}
