import 'package:dartboard/board/dart_board.dart';
import 'package:dartboard/widgets/game_state/game_state_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/game_notifier.dart';

class LocalGame extends StatelessWidget {
  const LocalGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentGame = context.read<GameNotifier>();
    currentGame.createNewLeg(player1: 'Player1', player2: 'Player2');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Local Game"),
      ),
      body: Column(
        children: [
          Expanded(child: GameStatePanel()),
          DartBoard(),
        ],
      ),
    );
  }
}
