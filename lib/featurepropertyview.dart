import 'package:flutter/cupertino.dart';
import './styles.dart';
class FeaturePropertyView extends StatelessWidget {

  final String property;
  final String? value;

  const FeaturePropertyView ({super.key, required this.property, required this.value});
  
  @override
  Widget build(BuildContext context) {
    return(
        Row(children: [
          Text('$property: ', style: ThemeStyle.title,),
          if(value != null) Text(value!),
          if(value == null) Text('null', style: ThemeStyle.nullStyle,)
        ],)
    );

  }
}