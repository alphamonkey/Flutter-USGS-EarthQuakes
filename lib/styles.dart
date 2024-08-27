import 'package:flutter/cupertino.dart';
import './colors.dart';

class ThemeStyle {
  static TextStyle subtitle = const TextStyle(color: ThemeColor.lightGray, fontSize: 12.0);
  static TextStyle countStyle = const TextStyle(color: ThemeColor.white, fontSize:20.0);
  static TextStyle lowMagStyle = const TextStyle(color: ThemeColor.lowMag);
  static TextStyle midMagStyle = const TextStyle(color: ThemeColor.midMag);
  static TextStyle highMagStyle = const TextStyle(color: ThemeColor.highMag);
  static TextStyle title = const TextStyle(color: ThemeColor.white, fontWeight: FontWeight.bold);
}