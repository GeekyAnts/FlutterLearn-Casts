import 'package:flutter/material.dart';
import 'package:google_maps_web/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps Web',
      home: MapScreen(),
    );
  }
}
