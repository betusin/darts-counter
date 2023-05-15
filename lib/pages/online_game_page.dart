import 'package:dartboard/board/dart_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/game_notifier.dart';
import '../widgets/game_state/game_state_panel.dart';

class OnlineGamePage extends StatelessWidget {
  final String gameID;
  final int myIndex;

  const OnlineGamePage({Key? key, required this.gameID, required this.myIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Started game with ID: $gameID');
    final game = context.read<GameNotifier>();
    game.createNewOnlineGame(gameID: gameID, myIndex: myIndex);
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
