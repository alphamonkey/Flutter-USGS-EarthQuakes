import 'package:flutter/cupertino.dart';
import './featurecollection.dart';
import './featuredetail.dart';

class FeatureList extends StatelessWidget {
const FeatureList({super.key, required this.featureCollection});
  final FeatureCollection? featureCollection;
  List<Text> getFeaturePlaces() {
    List<Text> ret = [];
    for (Feature f in featureCollection?.features ?? []) {
      ret.add(Text(f.properties.place));
    }
    return ret;
  }
@override
   Widget build(BuildContext context) {
    return  (
      Container(margin:EdgeInsets.all(16.0), decoration:BoxDecoration(borderRadius: BorderRadius.circular(24.0),
      color: CupertinoColors.darkBackgroundGray),
      
        child:
      ListView.builder(padding:const EdgeInsets.all(16.0),itemCount:featureCollection?.features.length, itemBuilder: (BuildContext context, int index) {
        return  GestureDetector(onTap: () {
          print(featureCollection?.features[index].properties.place);
          Navigator.push(context, CupertinoModalPopupRoute(builder: (context) => FeatureDetail(feature:featureCollection?.features[index]))
          );
      
        }, child:Container(height:44, child:Text(featureCollection?.features[index].properties.place ?? "")));
      }
    
      )
    )
    );

    }
}