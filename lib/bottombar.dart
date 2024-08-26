import 'package:flutter/cupertino.dart';
import './colors.dart';

class BottomBar extends StatelessWidget {
const BottomBar({super.key});

@override

  Widget build(BuildContext context) {
    return  (
      Container (height: 64.0,  
      
      decoration: BoxDecoration(color: CupertinoColors.darkBackgroundGray, 
      borderRadius: BorderRadius.circular(24.0)), 
      child: 
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children:[
            CupertinoButton(onPressed:null, child: Icon(CupertinoIcons.gear, size:36.0, color:ThemeColor.accentColor)),         
            Column(mainAxisAlignment: MainAxisAlignment.center,children:[Text('0 Earthquakes'), Text('Last Updated Never')], ), 
            CupertinoButton(onPressed: null, child: Icon(CupertinoIcons.arrow_counterclockwise, size:36.0, color:ThemeColor.accentColor))]))
    );

    }
}