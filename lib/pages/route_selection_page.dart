import 'package:flutter/material.dart';

class RouteSelectionPage extends StatefulWidget {
  const RouteSelectionPage({super.key});

  @override
  State<RouteSelectionPage> createState() => _RouteSelectionPageState();
}

class _RouteSelectionPageState extends State<RouteSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          const ListTile(
            title: Text(
              "Route 1"
            ),
            trailing: Text("test"),
          ),
        ],
      ),
    );
  }
}