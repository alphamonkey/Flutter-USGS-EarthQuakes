
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_usgs_earthquakes/featurelist.dart';
import './bottombar.dart';
import 'package:http/http.dart' as http;
import './featurecollection.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  


  Future<FeatureCollection> fetchFeatures() async {
    final response = await http.get(Uri.parse('https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-10'));
    if (response.statusCode == 200) {
      return FeatureCollection.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to get features');
    }
  }
  void onRefreshPressed() async {
     FeatureCollection features = await fetchFeatures();
      print(features.features[0].geometry.coordinates[0]);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(resizeToAvoidBottomInset: true,
        child: SafeArea(
          child:Column( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          mainAxisSize: MainAxisSize.max,
          children: 
            [FeatureList(), 
            BottomBar(onRefreshPressed: onRefreshPressed,)],
            )
          )
        ),
    );
  }
}


