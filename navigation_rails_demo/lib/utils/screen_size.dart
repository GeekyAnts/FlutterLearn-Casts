import 'package:flutter/material.dart';

bool isMediumScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 500;
}
