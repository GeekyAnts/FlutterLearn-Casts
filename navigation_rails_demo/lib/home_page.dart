import 'package:flutter/material.dart';
import 'package:navigation_rails_demo/components/custom_fab_button.dart';
import 'package:navigation_rails_demo/models/navigation_tabs.dart';
import 'package:navigation_rails_demo/utils/screen_size.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  PageController myPage = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    if (isMediumScreen(context)) {
      return Scaffold(
        body: Row(
          children: <Widget>[
            NavigationRail(
              leading: Padding(
                padding: EdgeInsets.only(bottom: 66, top: 66),
                child: Container(
                  height: 60,
                  width: 60,
                  child: CustomFabButton(),
                ),
              ),
              minWidth: 100,
              backgroundColor: Color.fromRGBO(22, 160, 133, 1),
              onDestinationSelected: (int index) {
                myPage.jumpToPage(index);
                setState(() {
                  currentIndex = index;
                });
              },
              labelType: NavigationRailLabelType.selected,
              selectedIconTheme: IconThemeData(
                color: Colors.white,
                opacity: 1.0,
              ),
              unselectedIconTheme: IconThemeData(
                color: Colors.white,
                opacity: 0.7,
              ),
              destinations: [
                ...navigationTabs.map(
                  (d) => NavigationRailDestination(
                      icon: Icon(
                        d.icon,
                        size: 44,
                      ),
                      label: Text(
                        d.title,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: d.index == currentIndex
                                ? Colors.white
                                : Colors.white60),
                      )),
                )
              ],
              selectedIndex: currentIndex,
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: Colors.white,
            ),
            Expanded(
              child: bodyWidget(myPage),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: Color.fromRGBO(22, 160, 133, 1),
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Container(
            height: 60,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ...navigationTabs.map((d) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        myPage.jumpToPage(d.index);
                      });
                    },
                    icon: Icon(
                      d.icon,
                      color: d.index == currentIndex
                          ? Colors.white
                          : Colors.white60,
                    ),
                  );
                })
              ],
            ),
          ),
        ),
        body: bodyWidget(myPage),
        floatingActionButton: CustomFabButton(),
      );
    }
  }

  Widget bodyWidget(myPage) {
    return PageView(
      controller: myPage,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      children: List.generate(4, (int i) {
        return bodyContainer(i);
      }),
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Widget bodyContainer(i) {
    return Container(
      child: Center(
        child: Text(
          "Page $i",
          style: TextStyle(color: Colors.grey, fontSize: 34),
        ),
      ),
    );
  }
}
