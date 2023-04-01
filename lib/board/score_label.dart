import 'package:dartboard/model/current_score_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScoreLabel extends StatelessWidget {
  const ScoreLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final currentScore = context.watch<CurrentScoreNotifier>();
    return Text(
      currentScore.getScore(),
      style: TextStyle(fontSize: 55),
    );
  }
}
