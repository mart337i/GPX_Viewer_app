

import 'dart:convert';
import 'dart:io';
import 'package:app_gpx_viewer/models/trail.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';


class TrailService {
  Future<Set<Polyline>> fetchTrailsPolyline() async {
    Set<Polyline> polylines = {};
    try {
      // 10.0.2.2:8000 for andriod emulator
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/get_trail/'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final trails = data['trails'].map<Trail>((trailJson) => Trail.fromJson(trailJson)).toList();

        for (var trail in trails) {
          final points = trail.getPolylinePoints();
          final polyline = Polyline(
            polylineId: PolylineId(trail.name),
            points: points,
            color: Colors.blue,
            width: 4,
          );
          polylines.add(polyline);
        }
      }
    } catch (e) {
      print("Production error: $e");
    }
    return polylines;
  }

  Future<Set<Polyline>> fetchDebugTrailPolyline() async {
    Set<Polyline> polylines = {};
    try {
      // 10.0.2.2:8000 for andriod emulator
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/gpx_test/'));
      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        final points = document.findAllElements('trkpt').map((node) {
          return LatLng(
            double.parse(node.getAttribute('lat')!),
            double.parse(node.getAttribute('lon')!),
          );
        }).toList();

        final polyline = Polyline(
          polylineId: PolylineId('debug_route'),
          points: points,
          color: Colors.blue,
          width: 4,
        );

        polylines.add(polyline);
      } else {
        throw HttpException('Failed to load GPX data');
      }
    } catch (e) {
      // Handle errors such as no internet connection, timeout, or invalid response
      print('An error occurred while fetching debug trail data: $e');
      // You might want to rethrow the error or handle it accordingly
    }

    return polylines;
  }
}