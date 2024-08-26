
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_usgs_earthquakes/featurelist.dart';
import './bottombar.dart';
import 'package:http/http.dart' as http;
import './featurecollection.dart';
import './colors.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<FeatureCollection> featureCollection;

  @override void initState() {
    super.initState();
    featureCollection = fetchFeatures();
  }

  Future<FeatureCollection> fetchFeatures() async {
    final end = DateTime.now();
    final start = end.subtract(Duration(hours:24));
    final endString = end.toIso8601String();
    final startString = start.toIso8601String();
    final response = await http.get(Uri.parse('https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=$startString&endtime=$endString'));
    if (response.statusCode == 200) {
      return FeatureCollection.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to get features');
    }
  }

  void onRefreshPressed() async {
     setState(() {});
     featureCollection = fetchFeatures();
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
          children: [Expanded(child:FutureBuilder(
            future: featureCollection, 
            builder: (context, snapshot) {
              print(snapshot.toString());
              if (snapshot.hasData && snapshot.connectionState != ConnectionState.waiting) {
                return FeatureList(featureCollection:snapshot.data);
              }
              else if (snapshot.hasError) {
                return Text('Error');
              } 
              else  {
                return Center(child:CupertinoActivityIndicator(animating: true, color: ThemeColor.accentColor, radius:22.0));
              }
            })),
            
            BottomBar(onRefreshPressed: onRefreshPressed,)],
            )
          )
        ),
    );
  }
}


