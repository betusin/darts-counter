import 'package:dartboard/board/dart_board.dart';
import 'package:dartboard/widgets/game_state/game_state_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/game_notifier.dart';

class LocalGamePage extends StatelessWidget {
  final int numberOfPlayers;
  final List<String> names;
  final int startingScore;

  const LocalGamePage({super.key, required this.numberOfPlayers, required this.names, this.startingScore = 501});

  @override
  Widget build(BuildContext context) {
    final currentGame = context.read<GameNotifier>();
    currentGame.createNewLocalGame(number: numberOfPlayers, names: names, starting: startingScore);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: GameStatePanel()),
            DartBoard(),
          ],
        ),
      ),
    );
  }
}
