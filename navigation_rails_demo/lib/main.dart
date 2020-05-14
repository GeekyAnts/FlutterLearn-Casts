import 'package:flutter/material.dart';
import 'package:navigation_rails_demo/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps Web',
      home: MyHomePage(),
    );
  }
}
