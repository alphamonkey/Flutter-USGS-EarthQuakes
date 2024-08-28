import 'package:flutter/cupertino.dart';
import './colors.dart';
import './styles.dart';

class TopBar extends StatelessWidget {
  final String title;
  const TopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return (Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(CupertinoIcons.xmark_square_fill,
                  size: 36.0, color: ThemeColor.highMag)),
          Text(title, style: ThemeStyle.title),
          const SizedBox(height: 36, width: 36)
        ]));
  }
}
