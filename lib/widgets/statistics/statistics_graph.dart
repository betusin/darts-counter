import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/game_statistics.dart';

const MAX_SIZE_X_DISPLAYED = 50;

class StatisticsGraph extends StatelessWidget {
  final GameStatistics statistics;

  const StatisticsGraph({Key? key, required this.statistics}) : super(key: key);

  LineChartData get sampleData => LineChartData(
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: getAveragesCount.toDouble(),
        maxY: statistics.averages.max,
        minY: 0,
        gridData: gridData,
        borderData: borderData,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border.all(color: Colors.blue, width: 2),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        barWidth: 4,
        color: Colors.blue,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: getSpots,
      );

  get getSpots => ([0.0] + statistics.averages)
      .reversed
      .take(getAveragesCount + 1)
      .toList()
      .reversed
      .mapIndexed((index, avg) => FlSpot(index.toDouble(), avg))
      .toList();

  get getAveragesCount => statistics.averages.length > MAX_SIZE_X_DISPLAYED
      ? MAX_SIZE_X_DISPLAYED
      : statistics.averages.length;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: LineChart(sampleData));
  }
}
