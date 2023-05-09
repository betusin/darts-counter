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
    final cardColor = isMyTurn ? Colors.blue : Colors.blue[100];
    final nameTagColor = isMyTurn ? Colors.green : Colors.green[100];

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(width: 2)
      ),
      child: Column(
        children: [
          _buildNameContainer(playerName, victories, cardColor!, nameTagColor!),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("$currentScore", style: TextStyle(fontSize: 48)),
                CurrentVisitPanel(visit: currentVisit),
                Text("Ø: ${currentAvg.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameContainer(String name, String victories, Color victoriesColor, Color nameTagColor) {
    return Container(
      decoration: BoxDecoration(
        color: nameTagColor,
        border: Border(bottom: BorderSide(width: 2))
      ),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: victoriesColor,
                border: Border(right: BorderSide(width: 2)),
            ),
            child: Center(child: Text(victories, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 30)
        ],
      ),
    );
  }
}
