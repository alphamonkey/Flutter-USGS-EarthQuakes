import 'package:flutter/cupertino.dart';

class FeatureList extends StatefulWidget {
const FeatureList({super.key});

  @override
  State<FeatureList> createState() => _FeatureListState();
}

class _FeatureListState extends State<FeatureList> {
  bool isLoading = false;
@override
   Widget build(BuildContext context) {
    return  (
      isLoading ? const Column(mainAxisAlignment:MainAxisAlignment.center,
      children:[CupertinoActivityIndicator(animating: true)] )
      :
      CupertinoListSection(
        children: const <Text> [Text('Foo'), Text('Bar')],
      )
    );

    }
}