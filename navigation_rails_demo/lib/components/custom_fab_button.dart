import 'package:flutter/material.dart';

class CustomFabButton extends StatefulWidget {
  @override
  _CustomFabButtonState createState() => _CustomFabButtonState();
}

class _CustomFabButtonState extends State<CustomFabButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animatedIcon;
  bool isTapped = false;
  Animation<Color> _animatedColor;
  Curve _curve = Curves.easeOut;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
    _animatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animatedColor = ColorTween(
      begin: Color.fromRGBO(52, 73, 94, 1),
      end: Color.fromRGBO(41, 128, 185, 1.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.00, 1.00, curve: _curve),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  startAnimation() {
    if (!isTapped) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isTapped = !isTapped;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: _animatedColor.value,
      elevation: 0.0,
      onPressed: startAnimation,
      child: AnimatedIcon(
        icon: AnimatedIcons.home_menu,
        size: 33,
        color: Colors.white,
        progress: _animatedIcon,
      ),
    );
  }
}
