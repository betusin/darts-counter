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
        children: [
          _buildGameBarButton(() {
            Navigator.pop(context);
          }, Colors.blue, 'Exit Game'),
          Expanded(
            child:
                _buildGameBarButton(currentGame.stepBack, Colors.red, 'Undo'),
          ),
          if (currentGame.getGameOver() && !currentGame.awaitingConfirmation())
            _buildGameBarButton(
                currentGame.newGameSamePlayers, Colors.blue, 'Next Game'),
          if (currentGame.awaitingConfirmation())
            _buildGameBarButton(
                currentGame.confirmTurn, Colors.blue, 'Confirm Score'),
        ],
      ),
    );
  }

  Widget _buildGameBarButton(VoidCallback callback, Color col, String text) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(backgroundColor: col),
        child: Text(text),
      ),
    );
  }
}
