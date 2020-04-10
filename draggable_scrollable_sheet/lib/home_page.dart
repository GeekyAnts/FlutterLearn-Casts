import 'package:flutter/material.dart';

import 'data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(4, 78, 147, 1),
      appBar: AppBar(
        title: Text(
          "Appbar",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment(0.0, -0.8),
            child: Text(
              "Map",
              style: TextStyle(fontSize: 42, color: Colors.white),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: Colors.white,
                ),
                //Scrollable widget
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  controller: scrollController,
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return cardsWidget(index);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget cardsWidget(itemIndex) => Container(
        margin: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color.fromRGBO(250, 124, 107, 1),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Icon(
                iconList[itemIndex],
                color: Colors.white,
                size: 54,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                data[itemIndex],
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      );
}
