import './settings.dart';
import 'package:flutter/cupertino.dart';
import './topbar.dart';
import './colors.dart';
import './settings.dart';
import './featurepropertyview.dart';
class SettingsView extends StatefulWidget {
  final Function()? onSettingsChange;
  @override
  State<SettingsView> createState() => _SettingsViewState(onSettingsChange: onSettingsChange);
  
  const SettingsView({
    super.key,
    this.onSettingsChange,
  });
}

class _SettingsViewState extends State<SettingsView> {
  double _radiusValue = 1.0;
  final Function()? onSettingsChange;
   _SettingsViewState({
      this.onSettingsChange,
  });
  @override 
  void initState() {
    super.initState();
    setupSliders();

  }

  void setupSliders() async {

      int radVal = await Settings.getInt('maxRadius');
      setState(() {
        _radiusValue = radVal.toDouble();
      });
      

  }
  @override


  Widget build(BuildContext context) {

    return (SafeArea(
         child: Container(
      decoration: const BoxDecoration(color: ThemeColor.darkGray),
      child: Column(children: [
        TopBar(title: 'Settings'),
        FeaturePropertyView(property: 'Max Radius', value: _radiusValue.toInt().toString()),
        CupertinoSlider(value: _radiusValue, min: 1.0, max: 500.0, onChanged: (newVal) {
          setState(() {
            _radiusValue = newVal;
          });
        },
        onChangeEnd: (value) {
          Settings.setInt('maxRadius', value.toInt());
          if (onSettingsChange != null) {
              onSettingsChange!();
          }
          
        }
        )
        ]
        
        ))));

  }
}