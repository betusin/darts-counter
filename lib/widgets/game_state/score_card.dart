import 'package:dartboard/widgets/game_state/current_visit_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/game_notifier.dart';

class ScoreCard extends StatelessWidget {

  final String name;

  final bool isFirst;

  const ScoreCard({super.key, required this.name, this.isFirst = false});

  @override
  Widget build(BuildContext context) {
    final currentGame = context.watch<GameNotifier>();
    final currentScore = isFirst ? currentGame.getPlayer1Score() : currentGame.getPlayer2Score();
    final currentAvg = isFirst ? currentGame.getPlayer1Average() : currentGame.getPlayer2Average();
    final currentVisit = isFirst ? currentGame.getPlayer1CurrentVisit() : currentGame.getPlayer2CurrentVisit();

    return Container(
      alignment: Alignment.center,
      color: (isFirst && currentGame.leg.player1Turn) || (!isFirst && !currentGame.leg.player1Turn) ? Colors.yellow : Colors.green,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(name),
          Text("$currentScore", style: TextStyle(fontSize: 50),),
          CurrentVisitPanel(first: currentVisit.getFirst(), second: currentVisit.getSecond(), third: currentVisit.getThird(),),
          Text("Ø: ${currentAvg.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
