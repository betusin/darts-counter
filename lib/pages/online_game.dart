import 'package:dartboard/board/dart_board.dart';
import 'package:flutter/material.dart';

class OnlineGame extends StatelessWidget {
  const OnlineGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Game"),
      ),
      body: DartBoard(),
    );
  }
}
