import 'package:dartboard/widgets/game_state/score_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/game_notifier.dart';

class ScorePanel extends StatelessWidget {
  const ScorePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final currentGame = context.watch<GameNotifier>();
    final int numberOfPlayers = currentGame.getNumberOfPlayers();
    final int currentPlayerIndex = (numberOfPlayers == 2) ? 0 : currentGame.getCurrentPlayerIndex();
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: (numberOfPlayers == 2) ? NeverScrollableScrollPhysics() : null,
      itemCount: numberOfPlayers,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 10,
          child: ScoreCard(index: (index + currentPlayerIndex) % numberOfPlayers),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 6),
    );
  }
}
