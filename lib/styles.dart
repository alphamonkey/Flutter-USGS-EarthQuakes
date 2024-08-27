import 'package:flutter/cupertino.dart';
import './colors.dart';

class ThemeStyle {
  static TextStyle subtitle = const TextStyle(color: ThemeColor.lightGray, fontSize: 12.0);
  static TextStyle countStyle = const TextStyle(color: ThemeColor.white, fontSize:20.0);
  static TextStyle lowMagStyle = const TextStyle(color: ThemeColor.lowMag, fontWeight: FontWeight.bold);
  static TextStyle midMagStyle = const TextStyle(color: ThemeColor.midMag, fontWeight: FontWeight.bold);
  static TextStyle highMagStyle = const TextStyle(color: ThemeColor.highMag, fontWeight: FontWeight.bold);
  static TextStyle title = const TextStyle(color: ThemeColor.white, fontWeight: FontWeight.bold);
  static TextStyle nullStyle = const TextStyle(color: ThemeColor.lightGray, fontStyle: FontStyle.italic);
}