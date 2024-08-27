import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import './colors.dart';
import './styles.dart';
import './featurecollection.dart';
import 'package:intl/intl.dart';


class FeatureListItem extends StatelessWidget {
  final Feature feature;
  final Position? position;

  const FeatureListItem({super.key, required this.feature, required this.position});
  
  double distanceMiles(double lat1, double lon1, double lat2, double lon2) {
        print('Latitude 1 $lat1 Longitude 1 $lon1');
   print('Latitude 2 $lat2 Longitude 2 $lon2');
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) * 0.000621371;

  }
  @override
  Widget build(BuildContext context) {
    Color selectedMagColor = ThemeColor.clear;
    TextStyle selectedStyle = ThemeStyle.lowMagStyle;
    if (feature.properties.mag case var mag?) {
      if (mag < 3.0) {
        selectedMagColor = ThemeColor.lowMag;
      } else if (mag >= 3.0 && mag < 6.0) {
        selectedMagColor = ThemeColor.midMag;
        selectedStyle = ThemeStyle.midMagStyle;
      } else if (mag >= 6.0) {
        selectedMagColor = ThemeColor.highMag;
        selectedStyle = ThemeStyle.highMagStyle;
      }
    }
    String _dateString = '';


      DateFormat formatter = DateFormat('MM/dd/yy h:mm a');
      _dateString = formatter
          .format(DateTime.fromMillisecondsSinceEpoch(feature.properties.time));
    
    return Row(children: [
      Column(mainAxisAlignment:MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          feature.shortName,
          style: ThemeStyle.title,
        ),
        SizedBox(height:4.0),
        Row(children:[
          Text('$_dateString', style: ThemeStyle.subtitle,),
          SizedBox(width: 60.0),
          if (position != null) Text('${distanceMiles(position!.latitude, position!.longitude, feature.latitude, feature.longitude).toInt()} mi', style: ThemeStyle.subtitle,)
        ])

      ]),
      Spacer(),
      if (feature.properties.mag != null)
        Icon(CupertinoIcons.graph_square, size: 24.0, color: selectedMagColor),
      if (feature.properties.mag != null)
        Text(
          ' ${feature.properties.mag!.toStringAsFixed(1)}',
          style: selectedStyle,
        ),
    ]);
  }
}
