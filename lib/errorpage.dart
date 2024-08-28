import 'package:flutter/cupertino.dart';
import './styles.dart';
import './colors.dart';

class ErrorPage extends StatelessWidget {
  final String errorTitle;
  final String errorMessage;

  const ErrorPage(
      {super.key, required this.errorMessage, required this.errorTitle});

  @override
  Widget build(BuildContext context) {
    return (Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(errorTitle, style: ThemeStyle.highMagStyle),
        Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(24.0),
            decoration:
                BoxDecoration(border: Border.all(color: ThemeColor.white)),
            child: Text(errorMessage))
      ],
    )));
  }
}
