import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  @override
  State createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<int> welcomeStringCount;
  static const String welcomeString =
      "Welcome to GeekyAnts, we are a product studio transforming ideas into reality.";
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      duration: Duration(seconds: 8),
      vsync: this,
    );
    welcomeStringCount =
        StepTween(begin: 0, end: welcomeString.length).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ))
          ..addStatusListener((state) {
            if (state == AnimationStatus.completed) {}
          })
          ..addListener(() {
            setState(() {});
          });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromRGBO(85, 98, 112, 1),
              Color.fromRGBO(78, 205, 196, 1),
            ])),
        child: welcomeStringCount == null
            ? null
            : Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 250,
                  margin: EdgeInsets.all(24),
                  child: AnimatedBuilder(
                    animation: welcomeStringCount,
                    builder: (BuildContext context, Widget child) {
                      String text =
                          welcomeString.substring(0, welcomeStringCount.value);
                      return Text(
                        text,
                        style: GoogleFonts.specialElite(
                            textStyle: TextStyle(
                                height: 1.5,
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
