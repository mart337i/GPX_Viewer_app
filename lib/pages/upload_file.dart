import 'package:app_gpx_viewer/pages/home_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xml/xml.dart'; // Make sure to add 'xml' package to your pubspec.yaml

import 'map_page.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({Key? key}) : super(key: key);

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  Future<Set<Polyline>> _parseGPXFile(List<int>? fileBytes, String fileName) async {
    // This function assumes 'fileBytes' is not null and contains the contents of a GPX file
    // Parse the GPX data
    final document = XmlDocument.parse(String.fromCharCodes(fileBytes!));
    final points = document.findAllElements('trkpt').map((node) {
      return LatLng(
        double.parse(node.getAttribute('lat') ?? '0'),
        double.parse(node.getAttribute('lon') ?? '0'),
      );
    }).toList();

    // Create a Polyline with the parsed points
    final polyline = Polyline(
      polylineId: PolylineId(fileName),
      points: points,
      color: Colors.blue,
      width: 4,
    );

    return {polyline}; // Return a Set containing the created Polyline
  }

  Future<void> _uploadAndNavigate(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any, allowMultiple: false);
    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      
      if (fileBytes != null) {
        final polylines = await _parseGPXFile(fileBytes, fileName);
        // Navigate to the MapPage with the polylines
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(initialPolylines: polylines),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _uploadAndNavigate(context),
                child: const Text("Upload file"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
