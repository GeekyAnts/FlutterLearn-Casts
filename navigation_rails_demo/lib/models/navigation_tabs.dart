import 'package:flutter/material.dart';

class NavigationTabs {
  final String title;
  final IconData icon;
  final int index;

  NavigationTabs({
    this.title,
    @required this.icon,
    this.index,
  });
}

List<NavigationTabs> navigationTabs = [
  NavigationTabs(title: "Albums", icon: Icons.album, index: 0),
  NavigationTabs(title: "History", icon: Icons.history, index: 1),
  NavigationTabs(title: "Images", icon: Icons.image, index: 2),
  NavigationTabs(title: "Music", icon: Icons.library_music, index: 3),
];
