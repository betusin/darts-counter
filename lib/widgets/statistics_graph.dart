import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsGraph extends StatelessWidget {
  const StatisticsGraph({Key? key}) : super(key: key);

  LineChartData get sampleData => LineChartData(
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 100,
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
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 20),
          FlSpot(5, 40),
          FlSpot(7, 30),
          FlSpot(10, 80),
          FlSpot(12, 55),
          FlSpot(13, 45),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Expanded(child: LineChart(sampleData));
  }
}
