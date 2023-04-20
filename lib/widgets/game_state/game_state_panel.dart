import 'package:dartboard/widgets/game_state/checkout_bar.dart';
import 'package:dartboard/widgets/game_state/score_panel.dart';
import 'package:flutter/material.dart';

import 'button_bar.dart';

class GameStatePanel extends StatelessWidget {
  const GameStatePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: ScorePanel()),
            SizedBox(height: 8.0),
            CheckoutBar(),
            GameButtonBar()
          ],
        ),
    );
  }
}
