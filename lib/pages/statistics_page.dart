import 'package:dartboard/model/game_statistics.dart';
import 'package:dartboard/service/game_statistics_service.dart';
import 'package:dartboard/widgets/handlers/handling_future_builder.dart';
import 'package:dartboard/widgets/statistics/statistics_graph.dart';
import 'package:flutter/material.dart';

import '../service/ioc_container.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Statistics'),
      ),
      body: HandlingFutureBuilder(
        future: get<GameStatisticsService>().getAllStatisticsForCurrentPlayer(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Column(
            children: [
              StatisticsGraph(statistics: snapshot.data),
              _buildDataTable(snapshot.data),
            ],
          );
        },
      ),
    );
  }

  DataTable _buildDataTable(GameStatistics statistics) {
    final rows = statistics.toMap().entries.map((entry) {
      return DataRow(
        cells: [
          DataCell(Text(entry.key)),
          DataCell(Text(entry.value.toString())),
        ],
      );
    }).toList();

    return DataTable(
      columns: const [
        DataColumn(label: Text('Statistic name')),
        DataColumn(
          label: Text('Value'),
          numeric: true,
        ),
      ],
      rows: rows,
    );
  }
}
