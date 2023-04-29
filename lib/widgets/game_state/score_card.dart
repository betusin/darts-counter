import 'package:dartboard/widgets/game_state/current_visit_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/game_notifier.dart';

class ScoreCard extends StatelessWidget {
  final int index;

  const ScoreCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final currentGame = context.watch<GameNotifier>();
    final currentScore = currentGame.getScore(index);
    final currentAvg = currentGame.getAverage(index);
    final currentVisit = currentGame.getVisit(index);
    final playerName = currentGame.getName(index);
    final isMyTurn = currentGame.isMyTurn(index);
    final victories = currentGame.getVictories(index).toString();

    return Container(
      alignment: Alignment.center,
      color: isMyTurn ? Colors.blue : Colors.blue[100],
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('$playerName - $victories', style: TextStyle(fontWeight: FontWeight.bold)),
          Text("$currentScore", style: TextStyle(fontSize: 50)),
          CurrentVisitPanel(visit: currentVisit),
          Text("Ø: ${currentAvg.toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
