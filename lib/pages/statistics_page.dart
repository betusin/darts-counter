import 'package:dartboard/widgets/statistics_graph.dart';
import 'package:dartboard/widgets/statistics_row.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> statistics = {
      "180sThrown": "10",
      "140sThrown": "37",
      "120sThrown": "79",
      "100checkouts": "6",
      "Accuracy": "24%"
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Statistics"),
      ),
      body: Column(
        children: [
          StatisticsGraph(),
          StatisticsRow(
            name: "180sThrown",
            value: statistics["180sThrown"],
          ),
          StatisticsRow(
            name: "140sThrown",
            value: statistics["140sThrown"],
          ),
          StatisticsRow(
            name: "120sThrown",
            value: statistics["120sThrown"],
          ),
          StatisticsRow(
            name: "100checkouts",
            value: statistics["100checkouts"],
          ),
          StatisticsRow(
            name: "Accuracy",
            value: statistics["Accuracy"],
          ),
        ],
      ),
    );
  }
}
