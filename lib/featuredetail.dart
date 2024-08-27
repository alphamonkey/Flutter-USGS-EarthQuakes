import 'package:flutter/cupertino.dart';
import 'colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './featurecollection.dart';
class FeatureDetail extends StatelessWidget {
const FeatureDetail({super.key, required this.feature});

final Feature? feature;

@override

  Widget build(BuildContext context) {
    return (SafeArea (child:Container(decoration: BoxDecoration(color: CupertinoColors.black), child:Column(children:[
                                    Row(children:[
                                        CupertinoButton(onPressed:(){Navigator.pop(context);}, child: Icon(CupertinoIcons.xmark_square_fill, size:36.0, color:ThemeColor.highMag)),   
                                        Text(feature?.properties.place ?? "No feature loaded.")
                                        ]
                                        ),
                                 
                           Expanded(child: Container(margin:EdgeInsets.all(16), child:GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(feature?.geometry.coordinates[1].toDouble() ?? 0.0, feature?.geometry.coordinates[0].toDouble() ?? 0.0), zoom:11.0)))),
                           Container(height:88, width:double.infinity, margin:EdgeInsets.all(8.0), decoration: BoxDecoration(color: CupertinoColors.darkBackgroundGray,), child:Text('Foo')),
                          ]),
                         )));
                    
  
    /*
      Container(decoration: BoxDecoration(color: CupertinoColors.black), child:
      Column(
                      children:[
                        
                        Row(children:[
                          CupertinoButton(onPressed:(){Navigator.pop(context);}, child: Icon(CupertinoIcons.xmark_square_fill, size:36.0, color:ThemeColor.highMag)),   
                          Text('foo')]),
                          Container(decoration: BoxDecoration(color: CupertinoColors.darkBackgroundGray),child:Text('Foo'),)
                          ]
                     
                        , )
                        */
            
                      

    }
}