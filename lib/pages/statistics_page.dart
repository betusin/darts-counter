import 'package:dartboard/widgets/statistics/statistics_graph.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Statistics'),
      ),
      body: Column(
        children: [
          StatisticsGraph(),
          _buildDataTable(),
        ],
      ),
    );
  }

  DataTable _buildDataTable() {
    final Map<String, String> dummyStatistics = {
      '180s Thrown': '10',
      '140s Thrown': '37',
      '120s Thrown': '79',
      "100+ Checkouts": "6",
      "Checkout accuracy": "24%"
    };

    final rows = dummyStatistics.entries.map((entry) {
      return DataRow(
        cells: [DataCell(Text(entry.key)), DataCell(Text(entry.value))],
      );
    }).toList();

    return DataTable(
      columns: const [
        DataColumn(label: Text("Statistic name")),
        DataColumn(
          label: Text("Value"),
          numeric: true,
        ),
      ],
      rows: rows,
    );
  }
}
