import 'package:flutter/material.dart';

class TrailCardStatic extends StatelessWidget {
  const TrailCardStatic({super.key});
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
                padding: EdgeInsets.all(16),
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
    );
  }
}