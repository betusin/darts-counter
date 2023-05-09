import 'package:dartboard/board/dart_board.dart';
import 'package:flutter/material.dart';

class OnlineGame extends StatelessWidget {
  final String gameID;

  const OnlineGame({Key? key, required this.gameID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Started game with ID: $gameID");
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Game"),
      ),
      body: DartBoard(),
    );
  }
}
