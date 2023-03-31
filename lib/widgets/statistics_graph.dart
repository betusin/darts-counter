import 'package:flutter/material.dart';

class STatisticsGraph extends StatelessWidget {
  const STatisticsGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Average in last 100 games"),
        Text("GRAPH"),
      ],
    );
  }
}
