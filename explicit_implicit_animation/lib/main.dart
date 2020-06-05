import 'package:explicit_implicit_animation/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
