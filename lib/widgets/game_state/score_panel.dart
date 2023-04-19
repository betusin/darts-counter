import 'package:dartboard/model/game_notifier.dart';
import 'package:dartboard/widgets/game_state/score_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScorePanel extends StatelessWidget {
  const ScorePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ScoreCard(name: "player1", isFirst: true,)),
        SizedBox(width: 8.0),
        Expanded(child: ScoreCard(name: "player2")),
      ],
    );
  }
}
