import 'package:flutter/cupertino.dart';
import 'package:flutter_usgs_earthquakes/featurecollection.dart';
import './colors.dart';
import 'package:intl/intl.dart';
class BottomBar extends StatelessWidget {
  final Function()? onRefreshPressed;
  final FeatureMetaData? metaData;

  const BottomBar({
    super.key,
    this.metaData,
    this.onRefreshPressed,
  });

  @override
  Widget build(BuildContext context) {
    String _dateString = '';

    if (metaData != null) {
      DateFormat formatter = DateFormat('MM/dd/yy hh:mm:ss');
      _dateString = formatter.format(DateTime.fromMillisecondsSinceEpoch(metaData!.generated));
    }
    
    int updateCount = metaData?.count ?? 0;
    return (Container(
        height: 64.0,
        decoration: BoxDecoration(
            color: CupertinoColors.darkBackgroundGray,
            borderRadius: BorderRadius.circular(24.0)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const CupertinoButton(
              onPressed: null,
              child: Icon(CupertinoIcons.gear,
                  size: 36.0, color: ThemeColor.accentColor)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$updateCount Earthquakes'),
              if(metaData != null )  Text('Last Updated: $_dateString')
              
              
            ],
          ),
          CupertinoButton(
              onPressed: onRefreshPressed,
              child: const Icon(CupertinoIcons.arrow_counterclockwise,
                  size: 36.0, color: ThemeColor.accentColor))
        ])));
  }
}
