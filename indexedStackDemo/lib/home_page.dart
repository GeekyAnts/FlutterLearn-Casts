import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(22, 160, 133, 1),
        title: Text("IndexedStack"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: IndexedStack(
              alignment: Alignment(0.0, 0.0),
              index: _currentIndex,
              children: <Widget>[
                Image.asset(
                  "assets/shirt1.jpg",
                  width: 300,
                  height: 400,
                ),
                Image.asset(
                  "assets/shirt2.jpg",
                  width: 300,
                  height: 400,
                ),
                Image.asset(
                  "assets/shirt3.jpg",
                  width: 300,
                  height: 400,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  if (_currentIndex <= 0) return;
                  setState(() {
                    _currentIndex -= 1;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  if (_currentIndex >= 2) return;
                  setState(() {
                    _currentIndex += 1;
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
