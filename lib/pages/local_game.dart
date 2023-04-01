import 'package:dartboard/board/dart_board.dart';
import 'package:flutter/material.dart';

class LocalGame extends StatelessWidget {
  const LocalGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Game"),
      ),
      body: DartBoard(),
    );
  }
}
