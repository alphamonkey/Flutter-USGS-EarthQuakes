import 'package:flutter/cupertino.dart';
import 'package:flutter_usgs_earthquakes/colors.dart';
import './featurecollection.dart';
import './featuredetail.dart';
import './featurelistitem.dart';
import 'package:geolocator/geolocator.dart';

class FeatureList extends StatelessWidget {
const FeatureList({super.key, required this.featureCollection, required this.position});
  final FeatureCollection featureCollection;
  final Position? position;

  List<Text> getFeaturePlaces() {
    List<Text> ret = [];
    for (Feature f in featureCollection.features) {
      ret.add(Text(f.properties.place));
    }
    return ret;
  }



@override
   Widget build(BuildContext context) {
    return  (
      Container(margin:EdgeInsets.all(12.0), decoration:BoxDecoration(borderRadius: BorderRadius.circular(16.0),
      color: ThemeColor.gray),
      
        child:
      ListView.builder(padding:const EdgeInsets.all(6.0),itemCount:featureCollection.features.length, itemBuilder: (BuildContext context, int index) {
        return  GestureDetector(onTap: () {
          Navigator.push(context, CupertinoModalPopupRoute(builder: (context) => FeatureDetail(feature:featureCollection.features[index]))
          );
      
        }, child:Container(margin:EdgeInsets.all(1), padding: EdgeInsets.symmetric(horizontal: 8.0, vertical:2.0), decoration: BoxDecoration(border: Border.all(color: ThemeColor.darkGray)), height:48, child:FeatureListItem(position:position, feature:featureCollection.features[index])));
      }
    
      )
    )
    );

    }
}