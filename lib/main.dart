
import 'package:flutter/cupertino.dart';
import 'package:flutter_usgs_earthquakes/featurelist.dart';
import './bottombar.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  void onRefreshPressed() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(resizeToAvoidBottomInset: true,
        child: SafeArea(
          child:Column( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          mainAxisSize: MainAxisSize.max,
          children: 
            [FeatureList(), 
            BottomBar()],
            )
          )
        ),
    );
  }
}


