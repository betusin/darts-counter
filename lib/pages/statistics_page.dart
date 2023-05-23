import 'package:dartboard/model/game_statistics.dart';
import 'package:dartboard/service/game_statistics_service.dart';
import 'package:dartboard/widgets/handlers/handling_future_builder.dart';
import 'package:dartboard/widgets/statistics/statistics_graph.dart';
import 'package:flutter/material.dart';

import '../service/ioc_container.dart';
import '../widgets/custom_app_bar.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Your Statistics'),
      ),
      body: HandlingFutureBuilder(
        future: get<GameStatisticsService>().getAllStatisticsForCurrentPlayer(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          GameStatistics gameStatistics = snapshot.data;

          return gameStatistics.isEmpty()
              ? _buildTextNoGames()
              : Column(
                  children: [
                    StatisticsGraph(statistics: gameStatistics),
                    _buildDataTable(gameStatistics),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildTextNoGames() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "No game has been played yet, therefore no statistics to display here.",
          style: TextStyle(fontSize: 20),
        ),
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
        DataColumn(label: Text('')),
        DataColumn(
          label: Text(''),
          numeric: true,
        ),
      ],
      rows: rows,
    );
  }
}
