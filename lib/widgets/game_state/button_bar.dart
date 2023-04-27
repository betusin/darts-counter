import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/game_notifier.dart';

class GameButtonBar extends StatelessWidget {
  const GameButtonBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentGame = context.watch<GameNotifier>();
    return Container(
      height: 40,
      color: Colors.blue[50],
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: currentGame.stepBack,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Undo'),
          ),
          if (currentGame.getGameOver()) ...[
            _buildWinnerText('${currentGame.getWinnerName()} WON'),
            _buildNextGameButton(currentGame.newGameSamePlayers)
          ]
        ],
      ),
    );
  }

  Widget _buildNextGameButton(VoidCallback callback) {
    return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        child: Text('Next Game'));
  }

  Widget _buildWinnerText(String winnerName) {
    return Text(winnerName);
  }
}
