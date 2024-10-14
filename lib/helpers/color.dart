import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoreColor {
  static Color primary = fromHex("#7210FF");
  static Color greyBackground = fromHex("#e6e6e6"); //e6e6e6
  static Color white = fromHex("#FFFFFF");
  static Color primaryLight = fromHex("#013B7D");
  static Color formField = fromHex("#F5F6F8");
  static Color formGrey = fromHex("#808A96");
  static Color blue = fromHex("#0C65C2");
  static Color noBlue = fromHex("#E7F0F9");
  static Color red = fromHex('#FB4D46');
  static Color noActive = fromHex("#B3C4D8");

  static Color green = fromHex('#4AAF57');

  static Color b1 = fromHex("#255DBE");
  static Color b2 = fromHex("#5A9BF8");

  static Color darkGray = fromHex("#616161");
  static Color primaryLighter = fromHex("#E9D9FF");
  static Color primarySelected = fromHex("#7210FF");

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
