import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/game_notifier.dart';
import 'constants.dart';

class HighlightingButton extends StatelessWidget {
  final Color backgroundColor;
  final int value;
  final bool isCircle;
  final bool isDouble;

  const HighlightingButton(
      {super.key,
      required this.backgroundColor,
      required this.value,
      this.isDouble = false,
      this.isCircle = false});

  @override
  Widget build(BuildContext context) {
    final currentGame = context.read<GameNotifier>();
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: isCircle ? MaterialStateProperty.all(CircleBorder()) : null,
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return highlightYellow;
            }
            return null;
          },
        ),
      ),
      onPressed: () {
        currentGame.addThrow(value, isDouble);
      },
      child: null,
    );
  }
}
