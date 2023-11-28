import 'package:app_gpx_viewer/components/custom_text_field.dart';
import 'package:app_gpx_viewer/components/trail_card_static.dart';
import 'package:flutter/material.dart';

class RouteSelectionPage extends StatefulWidget {
  const RouteSelectionPage({super.key});

  @override
  State<RouteSelectionPage> createState() => _RouteSelectionPageState();
}

class _RouteSelectionPageState extends State<RouteSelectionPage> {  
  final fuzzySearchController = TextEditingController();

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

           CustomTextField(
              controller: fuzzySearchController,
              obscure: false,
              hintText: "Search for a trail:"  
            ),

          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const TrailCardStatic();
              },
            ),
          ),
        ],
      ),
    );
  }
}