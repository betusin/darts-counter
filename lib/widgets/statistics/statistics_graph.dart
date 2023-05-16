import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/game_statistics.dart';

class StatisticsGraph extends StatelessWidget {
  final GameStatistics statistics;

  const StatisticsGraph({Key? key, required this.statistics}) : super(key: key);

  LineChartData get sampleData => LineChartData(
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: statistics.averages.length.toDouble(),
        maxY: statistics.averages.max,
        minY: 0,
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        barWidth: 4,
        color: Colors.blue,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: getSpots,
      );

  get getSpots =>
      [FlSpot(0, 0)] +
      statistics.averages
          .mapIndexed((index, avg) => FlSpot(index.toDouble(), avg))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Expanded(child: LineChart(sampleData));
  }
}
