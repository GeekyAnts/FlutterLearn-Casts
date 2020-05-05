import 'package:flutter/material.dart';
import 'package:google_maps_web/components/get_map_widget.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Google Maps."),
      ),
      body: Container(child: getMap()),
    );
  }
}
