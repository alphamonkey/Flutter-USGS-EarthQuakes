import 'package:flutter/material.dart';

import './settings.dart';
import 'package:flutter/cupertino.dart';
import './topbar.dart';
import './colors.dart';
import './settings.dart';
import './featurepropertyview.dart';

class SettingsView extends StatefulWidget {
  final Function()? onSettingsChange;
  @override
  State<SettingsView> createState() =>
      _SettingsViewState(onSettingsChange: onSettingsChange);

  const SettingsView({
    super.key,
    this.onSettingsChange,
  });
}

class _SettingsViewState extends State<SettingsView> {
  double _radiusValue = 1.0;
  double _daysValue = 1.0;
  double _minMag = 1.0;

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
    int daysVal = await Settings.getInt('daysAgo');
    double magVal = await Settings.getDouble('minMag');

    setState(() {
      _radiusValue = radVal.toDouble();
      _daysValue = daysVal.toDouble();
      _minMag = magVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (SafeArea(
        child: Container(
            decoration: const BoxDecoration(color: ThemeColor.darkGray),
            child: Column(children: [
              TopBar(title: 'Settings'),
              Container(padding: EdgeInsets.symmetric(horizontal: 12.0), child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                FeaturePropertyView(
                    property: 'Max Radius (miles)',
                    value: _radiusValue.toInt().toString()),
                    SizedBox(width: double.infinity, child:
                CupertinoSlider(
                  activeColor: ThemeColor.accentColor,
                    value: _radiusValue,
                    min: 1.0,
                    max: 500.0,
                    onChanged: (newVal) {
                      setState(() {
                        _radiusValue = newVal;
                      });
                    },
                    onChangeEnd: (value) {
                      Settings.setInt('maxRadius', value.toInt());
                      if (onSettingsChange != null) {
                        onSettingsChange!();
                      }
                    })),
                FeaturePropertyView(
                    property: 'Start Date (days ago)',
                    value: _daysValue.toInt().toString()),
                    SizedBox(width: double.infinity, child: CupertinoSlider(
                       activeColor: ThemeColor.accentColor,
                    value: _daysValue,
                    min: 1.0,
                    max: 365.0,
                    onChanged: (newVal) {
                      setState(() {
                        _daysValue = newVal;
                      });
                    },
                    onChangeEnd: (value) {
                      Settings.setInt('daysAgo', value.toInt());
                      if (onSettingsChange != null) {
                        onSettingsChange!();
                      }
                    }))
               ,
                FeaturePropertyView(
                    property: 'Minimum Magnitude',
                    value: _minMag.toStringAsFixed(1)),
                    SizedBox(width: double.infinity, child: CupertinoSlider(
                       activeColor: ThemeColor.accentColor,
                    value: _minMag,
                    min: 0.0,
                    max: 10.0,
                    onChanged: (newVal) {
                      setState(() {
                        _minMag = newVal;
                      });
                    },
                    onChangeEnd: (value) {
                      Settings.setDouble('minMag', value);
                      if (onSettingsChange != null) {
                        onSettingsChange!();
                      }
                    }))
                
              ]))
            ]))));
  }
}
