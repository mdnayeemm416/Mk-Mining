import 'package:flutter/material.dart';

class AppSizes {
  static double height(context) => MediaQuery.of(context).size.height;
  static double width(context) => MediaQuery.of(context).size.width;

  static const double bodyPadding = 10;
  static const double radius = 8;
}
