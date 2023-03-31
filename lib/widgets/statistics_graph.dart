import 'package:flutter/material.dart';

class StatisticsGraph extends StatelessWidget {
  const StatisticsGraph({Key? key}) : super(key: key);

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
