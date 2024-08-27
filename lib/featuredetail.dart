import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './featurecollection.dart';
import './topbar.dart';

class FeatureDetail extends StatelessWidget {
  FeatureDetail({super.key, required this.feature});

  final Feature? feature;
  final Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    if (feature != null) {
      markers.add(Marker(
          markerId: MarkerId(feature!.id),
          position: LatLng(feature!.geometry.coordinates[1].toDouble(),
              feature!.geometry.coordinates[0].toDouble())));
    }

    return (SafeArea(
        child: Container(
      decoration: const BoxDecoration(color: CupertinoColors.black),
      child: Column(children: [
        TopBar(title: feature?.properties.place ?? "No Feature Loaded"),
        Expanded(
            child: Container(
          margin: const EdgeInsets.all(16),
          child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      feature?.geometry.coordinates[1].toDouble() ?? 0.0,
                      feature?.geometry.coordinates[0].toDouble() ?? 0.0),
                  zoom: 11.0),
              markers: markers),
        )),
        Container(
            height: 88,
            width: double.infinity,
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: CupertinoColors.darkBackgroundGray,
            ),
            child: const Text('Foo')),
      ]),
    )));
  }
}
