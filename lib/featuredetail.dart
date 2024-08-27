import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './featurecollection.dart';
import './topbar.dart';
import './colors.dart';
import './featurepropertyview.dart';
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
      decoration: const BoxDecoration(color: ThemeColor.darkGray),
      child: Column(children: [
        TopBar(title: feature?.properties.place ?? "No Feature Loaded"),
        Expanded(
            // Rounded corners don't work with Google Maps Flutter (yet)
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
          margin: const EdgeInsets.symmetric(horizontal:12.0),
          child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      feature?.geometry.coordinates[1].toDouble() ?? 0.0,
                      feature?.geometry.coordinates[0].toDouble() ?? 0.0),
                  zoom: 11.0),
              markers: markers),
        )),
        Container(
            padding:EdgeInsets.all(8.0),
            height: 108,
            width: double.infinity,
            margin: const  EdgeInsets.symmetric(horizontal:8.0, vertical:12.0),
            decoration:  BoxDecoration(
              color: ThemeColor.gray,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(mainAxisSize:MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment:  CrossAxisAlignment.start, children: [
                FeaturePropertyView(property: "Place", value: feature?.properties.place),
                FeaturePropertyView(property: "Magnitude", value: '${feature?.properties.mag}'),
                FeaturePropertyView(property: "Alert", value: feature?.properties.alert),
                FeaturePropertyView(property: "Significance", value: '${feature?.properties.sig}'),
            ],),
        )]),
    )));
  }
}
