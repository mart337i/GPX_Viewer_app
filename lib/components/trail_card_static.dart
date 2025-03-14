import 'package:flutter/material.dart';

class TrailCardStatic extends StatelessWidget {
  const TrailCardStatic({super.key});
  final String defaultImageAsset = 'static/images/template.jpeg';
  
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  child: Image.asset(
                    defaultImageAsset,
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Furesø Loop',
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                              Text('Farum, Capital Region of Denmark, Denmark',
                                  style: TextStyle(color: Colors.white, fontSize: 12)),
                              Text('Length: 21.2 km • Est. 4h 32m',
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
        ),
      ),
    );
  }
}