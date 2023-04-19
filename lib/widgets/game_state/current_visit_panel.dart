import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/game_notifier.dart';

class CurrentVisitPanel extends StatelessWidget {

  final String first;
  final String second;
  final String third;

  const CurrentVisitPanel({super.key, required this.first, required this.second, required this.third});

  @override
  Widget build(BuildContext context) {
    final currentScore = context.watch<GameNotifier>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildScoreContainer(first),
        _buildScoreContainer(second),
        _buildScoreContainer(third)
      ],
    );
  }
  
  Widget _buildScoreContainer(String text) {
    return Container(
      alignment: Alignment.center,
      width: 55,
      height: 70,
      color: Colors.black,
      child: Text(text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
