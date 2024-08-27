import 'package:native_shared_preferences/native_shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class Settings {
  static Map<String, num> defaults = {
    'maxRadius':50,
    'minMag':1.0,
    'daysAgo':1.0
  };
  static Future<int> getInt(String name) async {
    NativeSharedPreferences prefs = await NativeSharedPreferences.getInstance();
    int? ret = prefs.getInt(name);
    
    if (ret case var ret?) {
      return ret;
    }

    return defaults[name]!.toInt();

  }
  static Future<double> getDouble(String name) async {
    NativeSharedPreferences prefs = await NativeSharedPreferences.getInstance();
    double? ret = prefs.getDouble(name);
    
    if (ret case var ret?) {
      return ret;
    }

    return defaults[name]!.toDouble();

  }
  static void setInt(String name, int value) async {
    NativeSharedPreferences prefs = await NativeSharedPreferences.getInstance();
    await prefs.setInt(name, value);
  }

    static void setDouble(String name, double value) async {
    NativeSharedPreferences prefs = await NativeSharedPreferences.getInstance();
    await prefs.setDouble(name, value);
  }
}