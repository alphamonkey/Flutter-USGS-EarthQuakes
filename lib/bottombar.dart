import 'package:flutter/cupertino.dart';
import 'package:flutter_usgs_earthquakes/featurecollection.dart';
import './styles.dart';
import './colors.dart';
import 'package:intl/intl.dart';
import './settingsview.dart';

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
    String dateString = '';

    if (metaData != null) {
      DateFormat formatter = DateFormat('MM/dd/yy h:mm:ss a');
      dateString = formatter
          .format(DateTime.fromMillisecondsSinceEpoch(metaData!.generated));
    }

    return (Container(
        height: 64.0,
        decoration: BoxDecoration(
            color: ThemeColor.gray, borderRadius: BorderRadius.circular(24.0)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CupertinoButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoModalPopupRoute(
                        builder: (context) => SettingsView(
                              onSettingsChange: onRefreshPressed,
                            )));
              },
              child: const Icon(CupertinoIcons.gear,
                  size: 36.0, color: ThemeColor.accentColor)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${metaData?.count ?? 0} Earthquakes',
                style: ThemeStyle.countStyle,
              ),
              if (metaData != null) const SizedBox(height: 4.0),
              if (metaData != null)
                Text(
                  'Last Updated: $dateString',
                  style: ThemeStyle.subtitle,
                )
            ],
          ),
          CupertinoButton(
              onPressed: onRefreshPressed,
              child: const Icon(CupertinoIcons.arrow_counterclockwise,
                  size: 36.0, color: ThemeColor.accentColor))
        ])));
  }
}
