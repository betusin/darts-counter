import 'package:flutter/material.dart';

import '../../model/visit.dart';

class CurrentVisitPanel extends StatelessWidget {
  final Visit visit;

  const CurrentVisitPanel({super.key, required this.visit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildScoreContainer(visit.getFirst()),
        _buildScoreContainer(visit.getSecond()),
        _buildScoreContainer(visit.getThird())
      ],
    );
  }

  Widget _buildScoreContainer(String text) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: Container(
        alignment: Alignment.center,
        width: 55,
        height: 70,
        color: Colors.black,
        child: Text(
          text,
          style: TextStyle(
              color: visit.isBusted ? Colors.red : Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
