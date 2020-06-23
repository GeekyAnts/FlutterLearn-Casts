import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  @override
  State createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  bool showFloatingButton = false;
  bool showTextInput = false;
  bool hideTextInput = false;
  double _top = 10;
  String inputName = "";
  AnimationController animationController;
  Animation<int> welcomeStringCount;
  static const String welcomeString =
      "Welcome to GeekyAnts, we are a product studio transforming ideas into reality.";
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
    welcomeStringCount =
        StepTween(begin: 0, end: welcomeString.length).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ))
          ..addStatusListener((state) {
            if (state == AnimationStatus.completed) {
              setState(() {
                showFloatingButton = true;
              });
            }
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
        child: Stack(
          children: [
            welcomeStringCount == null ? null : getAnimatedCrossFade(),
            _getAnimatedText(),
            Align(
              alignment: Alignment.bottomRight,
              child: getAnimatedOpacityButton(),
            ),
          ],
        ),
      ),
    );
  }

  _getAnimatedText() {
    return AnimatedPositioned(
      duration: Duration(seconds: 3),
      curve: Curves.bounceOut,
      child: _getAnimatedOpacityText(),
      top: _top,
      right: 200,
    );
  }

  _getAnimatedOpacityText() {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      opacity: hideTextInput ? 1 : 0,
      child: Container(
        child: Text(
          "Hey, $inputName",
          style: GoogleFonts.specialElite(
            textStyle: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  getAnimatedOpacityButton() {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      opacity: showFloatingButton ? 1 : 0,
      child: getButton(),
    );
  }

  getButton() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: FloatingActionButton(
        onPressed: showTextInput
            ? () {
                setState(() {
                  hideTextInput = true;
                  showFloatingButton = false;
                  _top = 300;
                });
              }
            : () {
                setState(() {
                  showTextInput = true;
                });
              },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black38,
        ),
      ),
    );
  }

  getAnimatedCrossFade() {
    return AnimatedCrossFade(
      duration: Duration(seconds: 1),
      alignment: Alignment.centerLeft,
      firstChild: _getTextTypewriterExplicitAnimation(),
      firstCurve: Curves.fastOutSlowIn,
      secondChild: _hideTextInputWidget(),
      secondCurve: Curves.easeIn,
      crossFadeState:
          showTextInput ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }

  _hideTextInputWidget() {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      opacity: hideTextInput ? 0 : 1,
      child: _getTextInput(),
    );
  }

  _getTextTypewriterExplicitAnimation() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 250,
        margin: EdgeInsets.all(24),
        child: AnimatedBuilder(
          animation: welcomeStringCount,
          builder: (BuildContext context, Widget child) {
            String text = welcomeString.substring(0, welcomeStringCount.value);
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
    );
  }

  _getTextInput() {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Container(
        width: 300,
        height: 120,
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Hey, May I know your name?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  primaryColor: Colors.white,
                  accentColor: Colors.white,
                  hintColor: Colors.white,
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      inputName = value;
                    });
                  },
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(55.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(55.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.black26,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
