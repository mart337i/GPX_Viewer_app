

import 'dart:convert';
import 'dart:io';
import 'package:app_gpx_viewer/models/trail.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';


class TrailService {
  Future<List<Trail>> fetchTrails() async {
    List<Trail> trails = [];
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/trail/trails/?page=1&size=50'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items']; // Assuming 'items' key for paginated data
        final mappedTrailData = items.map<Trail>((trailJson) => Trail.fromJson(trailJson)).toList();
        trails = mappedTrailData;
      } else {
        print('Failed to fetch trails with status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching trails: $e");
    }
    return trails;
  }

  Future<Set<Polyline>> getTrail(String fileName) async {
    Set<Polyline> polylines = {};
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/trail/get-gpx/$fileName'));
      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        final points = document.findAllElements('trkpt').map((node) {
          return LatLng(
            double.parse(node.getAttribute('lat')!),
            double.parse(node.getAttribute('lon')!),
          );
        }).toList();

        final polyline = Polyline(
          polylineId: PolylineId(fileName),
          points: points,
          color: Colors.blue,
          width: 4,
        );

        polylines.add(polyline);
      } else {
        print('Failed to load GPX data with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching GPX file: $e');
    }

    return polylines;
  }

  Future<Set<Polyline>> fetchDebugTrailPolyline() async {
    Set<Polyline> polylines = {};
    try {
      // 10.0.2.2:8000 for andriod emulator
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/gpx_test/'), 
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      });
      if (response.statusCode == 200) {
        print(response.headers["name"]);
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