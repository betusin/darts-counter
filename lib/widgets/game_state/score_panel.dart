import 'package:dartboard/widgets/game_state/score_card.dart';
import 'package:flutter/material.dart';

class ScorePanel extends StatelessWidget {
  const ScorePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScoreCard(
          index: 0,
        ),
        ScoreCard(
          index: 1,
        ),
      ],
    );
  }
}
