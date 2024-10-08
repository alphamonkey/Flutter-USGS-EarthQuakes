import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_usgs_earthquakes/featurelist.dart';
import './bottombar.dart';
import 'package:http/http.dart' as http;
import './featurecollection.dart';
import './colors.dart';
import 'package:geolocator/geolocator.dart';
import './settings.dart';
import './errorpage.dart';

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

  Position? position;

  String _errorTitle = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    featureCollection = fetchFeatures();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      setState(() {
        _errorTitle = "Location Services";
        _errorMessage =
            "Location services are disabled.  Enable them in settings to use the app";
      });

      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _errorTitle = "Location Services";
          _errorMessage =
              "Permission to use your location has been denied.  Please allow in settings to use the app";
        });
        return Future.error('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _errorTitle = "Location Services";
        _errorMessage =
            "Permission to use your location has been denied.  Please allow in settings to use the app";
      });
      return Future.error('Location permission permanantly denied');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<FeatureCollection> fetchFeatures() async {
    final end = DateTime.now();

    final maxRadius = await Settings.getInt('maxRadius') * 1.60934;
    final daysAgo = await Settings.getInt('daysAgo');
    final minMag = await Settings.getDouble('minMag');
    final start = end.subtract(Duration(days: daysAgo));
    final endString = end.toIso8601String();
    final startString = start.toIso8601String();
    position = await determinePosition();

    final latitude = position?.latitude;
    final longitude = position?.longitude;

    if (latitude == null || longitude == null) {
      setState(() {
        _errorTitle = "Location Services";
        _errorMessage =
            "Unable to retrieve your location.  Please allow this app to use location services in settings.";
      });

      throw Exception('No location available');
    }

    final response = await http
        .get(Uri.parse(
            'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=$startString&endtime=$endString&latitude=$latitude&longitude=$longitude&maxradiuskm=$maxRadius&minmagnitude=$minMag&orderby=magnitude&eventtype=earthquake'))
        .catchError((err) {
      setState(() {
        _errorTitle = "Connection error";
        _errorMessage = err.toString();
      });
      throw Exception('Connection error');
    });
    if (response.statusCode == 200) {
      return FeatureCollection.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      setState(() {
        _errorTitle = "HTTP Error ${response.statusCode}";
        _errorMessage = response.body;
      });
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
      home: CupertinoPageScaffold(
          backgroundColor: ThemeColor.darkGray,
          resizeToAvoidBottomInset: true,
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: FutureBuilder(
                      future: featureCollection,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState !=
                                ConnectionState.waiting) {
                          return FeatureList(
                              position: position,
                              featureCollection: snapshot.data!);
                        } else if (snapshot.hasError) {
                          return ErrorPage(
                            errorTitle: _errorTitle,
                            errorMessage: _errorMessage,
                          );
                        } else {
                          return const Center(
                              child: CupertinoActivityIndicator(
                                  animating: true,
                                  color: ThemeColor.accentColor,
                                  radius: 22.0));
                        }
                      })),
              FutureBuilder(
                  future: featureCollection,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState != ConnectionState.waiting) {
                      return BottomBar(
                        metaData: snapshot.data?.metadata,
                        onRefreshPressed: onRefreshPressed,
                      );
                    }
                    return BottomBar(
                      onRefreshPressed: onRefreshPressed,
                    );
                  })
            ],
          ))),
    );
  }
}
